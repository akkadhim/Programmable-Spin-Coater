#line 1 "E:/programming/Microcontroller/Projects/Programmable spin coater/BLDC/BrushlessPIC.c"
#line 19 "E:/programming/Microcontroller/Projects/Programmable spin coater/BLDC/BrushlessPIC.c"
sbit MOTOR_DIR at RB2_bit;



sbit LD1 at LATA0_bit;
sbit LD2 at LATA1_bit;
sbit LD1_Direction at TRISA0_bit;
sbit LD2_Direction at TRISA1_bit;

sbit T1 at RD3_bit;
sbit T2 at RD2_bit;
sbit T1_Direction at TRISD3_bit;
sbit T2_Direction at TRISD2_bit;

unsigned current_speed=0;
unsigned int pwm_period;
unsigned mode=0,speed1=0,speed2=0,interval1=0,interval2=0;

unsigned char readbuff[64];
unsigned char writebuff[64]="Spin Coating Device";
unsigned short x1,x2,x3,x4;
char txt[4];
unsigned res=0;
unsigned TmrSclr=0,Interval=0,tm5sclr=0;
unsigned OldTmr=0, OldSpd=0;
bit BtnRED, TimerOut;
char CR_LF[5]={0};

void Interrupt(){

 if (TMR0IF_bit){
 if (TmrSclr<Interval){
 TmrSclr++ ;
 }
 else{
 TmrSclr = 0;
 PWM9_Stop();
 TMR0IE_bit = 0;
 TimerOut = 1;
 }
 TMR0IF_bit = 0;
 }

 if (USBIF_bit){
 USB_Interrupt_Proc();
 }

 if (INT0IF_bit){
 BtnRED = 1;
 INT0IF_bit=0;
 TMR3IE_bit=0;
 TMR5IE_bit=0;
 TMR0IE_bit=0;
 }

 if (TMR5IF_bit){
 if (tm5sclr == 24){
 TMR3IE_bit=0;
 TMR5IE_bit=0;
 TMR5H = 0x15;
 TMR5L = 0xA0;
 }
 else{
 tm5sclr ++;
 TMR5IF_bit = 0;
 TMR5H = 0x15;
 TMR5L = 0xA0;
 }
 }
}

int GetParameters(){
 int cnt = 0 ;
 while(1){
 while(!HID_Read());
 LD1=~LD1;
 res = strncmp(readbuff, "Message", 7);
 if (res == 0 ){
 res = strstr(readbuff, "Mode");
 if (res != 0){
 mode = readbuff[11]-48;
 }
 res = strstr(readbuff, "Speed1");
 if (res != 0){
 x4=readbuff[18]-48;
 x3=readbuff[19]-48;
 x2=readbuff[20]-48;
 x1=readbuff[21]-48;
 speed1 = x4*1000 + x3*100 + x2*10 + x1;
 }
 res = strstr(readbuff, "Speed2");
 if (res != 0){
 x4=readbuff[28]-48;
 x3=readbuff[29]-48;
 x2=readbuff[30]-48;
 x1=readbuff[31]-48;
 speed2 = x4*1000 + x3*100 + x2*10 + x1;
 }
 res = strstr(readbuff, "Interval1");
 if (res != 0){
 x4=readbuff[41]-48;
 x3=readbuff[42]-48;
 x2=readbuff[43]-48;
 x1=readbuff[44]-48;
 interval1 = x4*1000 + x3*100 + x2*10 + x1;
 }
 res = strstr(readbuff, "Interval2");
 if (res != 0){
 x4=readbuff[54]-48;
 x3=readbuff[55]-48;
 x2=readbuff[56]-48;
 x1=readbuff[57]-48;
 interval2 = x4*1000 + x3*100 + x2*10 + x1;
 }
 if (mode == 0 || speed1 == 0 || interval1 == 0){
 memset(writebuff, 0, 64);
 memcpy(writebuff, "No Parameters Or Stopped", 24);
 strcat(writebuff,CR_LF);
 while(!HID_Write(&writebuff,64));
 return 0;
 }
 else {
 memset(writebuff, 0, 64);
 BtnRED = 0;
 return 1;
 }
 }
 }
}

void SetTimer(unsigned time){
 Interval = time;
 TimerOut = 0;
 BtnRED = 0;
 TMR0IE_bit = 1;
}

void SetSpeed(unsigned speed){
 current_speed = (speed);
 PWM9_Set_Duty(current_speed);
 PWM9_Start();
}

void GetSpeed(){
 TMR3L = 0;
 TMR3H = 0;
 TMR5H = 0x15;
 TMR5L = 0xA0;
 TMR3IE_bit = 1;
 TMR5IE_bit = 1;
}

void CalcSpeed(){
 while(BtnRED == 0 && TimerOut == 0){
 GetSpeed();
 if (TmrSclr > OldTmr){
 memset(writebuff, 0, 64);

 memcpy(writebuff, "Progress=", 9);
 OldTmr = TmrSclr;
 ByteToStr(TmrSclr,txt);
 writebuff[9]=0;
 strcat(writebuff,Ltrim(Rtrim((txt))));

 strcat(writebuff, "Speed=");
 OldSpd = TMR3L;
 TMR3L = 0;
 TMR3H = 0;
 WordToStr(OldSpd,txt);

 strcat(writebuff,Ltrim(Rtrim(txt)));
 strcat(writebuff,CR_LF);
 while(!HID_Write(&writebuff,64));
 }
 }
 BtnRED = 0;
 PWM9_Stop;
 OldTmr = 0;
 OldSpd = 0;
 memset(writebuff, 0, 64);
 memcpy(writebuff, "Stop", 4);
 strcat(writebuff,CR_LF);
 while(!HID_Write(&writebuff,64));
}


void MCU_Init(){
 ADCON0 = 0;
 ADCON1 = 0;
 ANCON0 = 0xFF;
 ANCON1 = 0xFF;
 TRISB.F3 = 1;

 res = PPS_Mapping(6, _INPUT, _T3CKI);
 T3CON = 0b10000001;
 T5CON = 0b00110001;
 TMR3IF_bit = 0;
 TMR5IF_bit = 0;

 HID_Enable(&readbuff,&writebuff);
 GIE_bit = 1;
 T1_Direction = 1;
 T2_Direction = 1;
 LD1_Direction = 0;
 LD2_Direction = 0;
 LD1 = 0;
 LD2 = 0;
 LD1=1;
 LD2=1;
 TRISB2_bit = 0;
 TRISC6_bit = 0;
 Delay_ms(100);

 current_speed = 0;
 PWM9_Init(8000);
 PWM9_Set_Duty(0);
 MOTOR_DIR =  0x00 ;

 T0CON = 0x87;
 TMR0H = 0x48;
 TMR0L = 0xE5;

 INT0IE_bit = 1;
 INTEDG0_bit = 1;

 GIE_bit = 1;
}

void main(){
 MCU_Init();
 CR_LF[0] = 0x0D;
 CR_LF[1] = 0x0A;
 strcat(writebuff,CR_LF);
 while(!HID_Write(&writebuff,64));

 while(1){
 while(GetParameters()){
 if ( mode == 1 && BtnRED == 0){
 SetTimer(interval1);
 SetSpeed(speed1);
 CalcSpeed();
 }
 else if (mode == 2 && BtnRED == 0){
 SetTimer(interval1);
 SetSpeed(speed1);
 CalcSpeed();
 SetTimer(interval2);
 SetSpeed(speed2);
 CalcSpeed();
 }

 mode=0;
 speed1 = 0;
 speed2 = 0;
 Interval1 = 0;
 Interval2 = 0;
 }
 }
}
