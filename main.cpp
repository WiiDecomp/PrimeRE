#include <list>
#include <cstdio>
int r0;
int r1;
int r2;
int r3;
int r4;
int r5;
int r6;
int fakeram_800000F;
std::list <int> fakestack[65535];
void func_8037F0D4(){};
void func_80003278(){};
void func_8037DFEC(){};
int func_80003354(){
    // DECOMP:
    /* 80003354 00000354  7C 00 00 A6 */	//mfmsr r0
    /* 80003358 00000358  60 00 20 00 */	//ori r0, r0, 0x2000
    /* 8000335C 0000035C  7C 00 01 24 */	//mtmsr r0
    /* 80003360 00000360  7F E8 02 A6 */	//mflr r31
    func_8037DFEC();
    func_8037F0D4();
    // DECOMP:
    /* 8000336C 0000036C  7F E8 03 A6 */	//mtlr r31
    return 0;
}; // Returns in r0
int func_80003294(int arg1 /* r0 */){
    return 0;
};
int lbl_80003188(){
    return 0;
}; // Returns in r7
void lbl_800031A8(){};

int main(){
    int thingthatweaddnegative1to;
    func_80003278();
    thingthatweaddnegative1to = func_80003354();
    printf("Thingy is %d", thingthatweaddnegative1to);
    int buffer_minus8; // Note: This stores the contents of -8 in 8000314C
    int buffer_4; // Same for minus8, but with 4
    int buffer_0; // Same with 4, but with 0
    thingthatweaddnegative1to += -1; // Todo, Is this right?
    //  ^^^  
    // Here's an assumption I made.
    // I belive the below func takes r0 as an argument.
    // Todo, investigate
    // DECOMP: 
    /* 8000314C 0000014C  94 21 FF F8 */	// stwu r1, -8(r1)
    /* 80003150 00000150  90 01 00 04 */	// stw r0, 4(r1)
    /* 80003154 00000154  90 01 00 00 */	// stw r0, 0(r1)
    /*
    li is a pseudo-opcode which actually translates as an addi instruction.

    addi rD, rA, SIMM adds the signed immediate SIMM to rA, placing the result in rD, 
    except when the rA field is 0, in which case it specifies a literal 0 instead of 
    r0. li rD, SIMM is really addi rD, 0, SIMM.
    */
    // The PPC docs for stwu invalidate 8000314C???
    // stwu 6,buffer(4) is stated in the PPC docs
    // This would make the buffer -8 in this case????????????????
    buffer_minus8 = r1;
    r1 = buffer_minus8;
    buffer_4 = r0;
    r1 = buffer_4;
    buffer_0 = r0;
    r1 = buffer_0;
    func_80003294(thingthatweaddnegative1to);
    r0 = 0; // This looks wrong.
    r6 += fakeram_800000F;
    r6 = buffer_0;    /* 80003174 00000174  80 C6 00 00 */	//lwz r6, 0(r6)
    if (r6 != lbl_80003188()){
        // DECOMP:
        /* 80003180 00000180  80 E6 00 0C */	//lwz r7, 0xc(r6)
        lbl_800031A8();
    }
    return 0;
}