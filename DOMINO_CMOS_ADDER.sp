DOMINO ADDER
**
* Author: tara Tandel (tara.tandel.94@gmail.com)
* Create Date: 28-08-2015
* File Name: DOMINO_CMOS_ADDER.sp
**

.param	Vsup=1.2

.protect

.SUBCKT FA A B CI S CO DD 0 CLK

.lib './32nm_MGK.l'   

.param	Wmin=32n
.param	Lmin=32n

M01	Co	CLK	dd	dd	pmos	w='2*Wmin'	l=Lmin

M011	Co	co_not	dd	dd	pmos	w='Wmin'	l=Lmin
M01111	s_not	s	dd	dd	pmos	w='Wmin'	l=Lmin

M06	Co	Ci_not	n3	0	nmos	w='3*Wmin'	l=Lmin
M07	n3	A_not	n2	0	nmos	w='3*Wmin'	l=Lmin
M08	n3	B_not	n2	0	nmos	w='3*Wmin'	l=Lmin

M09	Co	A_not	n4	0	nmos	w='3*Wmin'	l=Lmin
M10	n4	b_not	n2	0	nmos	w='3*Wmin'	l=Lmin

M2	n2	CLK	0	0	nmos	w='3*Wmin'	l=Lmin


M25	Co_not	Co	dd	dd	pmos	w='2*Wmin'	l=Lmin
M26	Co_not	Co	0	0	nmos	w=Wmin		l=Lmin



M11	S_not	CLK	dd	dd	pmos	w='2*Wmin'	l=Lmin

M18	S_not	Co_not	n8	0	nmos	w='3*Wmin'	l=Lmin
M19	n8	A	n7	0	nmos	w='3*Wmin'	l=Lmin
M20	n8	B	n7	0	nmos	w='3*Wmin'	l=Lmin
M21	n8	Ci	n7	0	nmos	w='3*Wmin'	l=Lmin

M22	S_not	Ci	n9	0	nmos	w='4.5*Wmin'	l=Lmin
M23	n9	B	n10	0	nmos	w='4.5*Wmin'	l=Lmin
M24	n10	A	n7	0	nmos	w='4.5*Wmin'	l=Lmin


M12	n7	CLK	0	0	nmos	w='3*Wmin'	l=Lmin


M27	S	S_not	dd	dd	pmos	w='2*Wmin'	l=Lmin
M28	S	S_not	0	0	nmos	w=Wmin		l=Lmin



M30	A_not	A	dd	dd	pmos	w='2*Wmin'	l=Lmin
M31	A_not	A	0	0	nmos	w=Wmin		l=Lmin

M32	B_not	B	dd	dd	pmos	w='2*Wmin'	l=Lmin
M33	B_not	B	0	0	nmos	w=Wmin		l=Lmin

M34	Ci_not	Ci	dd	dd	pmos	w='2*Wmin'	l=Lmin
M35	Ci_not	Ci	0	0	nmos	w=Wmin		l=Lmin




.ends

.unprotect


X_FA0	A0	B0	C_in	S0	C0	DD	0	CLK	FA
X_FA1	A1	B1	C0	S1	C1	DD	0	CLK	FA
X_FA2	A2	B2	C1	S2	C2	DD	0	CLK	FA
X_FA3	A3	B3	C2	S3	C_Out	DD	0	CLK	FA


** Source **

vDD	dd	0	DC=Vsup

V_Cin	C_in	0	DC=0

v_A0	A0	0	LFSR	0	Vsup	0	tr	tf	rate	1	[2,5] DC=STATE
v_A1	A1	0	LFSR	0	Vsup	0	tr	tf	rate	1	[1,5] DC=STATE
v_A2	A2	0	LFSR	0	Vsup	0	tr	tf	rate	1	[3,5] DC=STATE
v_A3	A3	0	LFSR	0	Vsup	0	tr	tf	rate	1	[4,5] DC=STATE

v_B0	B0	0	LFSR	0	Vsup	0	tr	tf	rate	1	[2,3] DC=STATE
v_B1	B1	0	LFSR	0	Vsup	0	tr	tf	rate	1	[2,4] DC=STATE
v_B2	B2	0	LFSR	0	Vsup	0	tr	tf	rate	1	[2,6] DC=STATE
v_B3	B3	0	LFSR	0	Vsup	0	tr	tf	rate	1	[1,3] DC=STATE

V_clk	CLK	0	Dc=1.2	pulse	0	Vsup	0	0.1n	0.1n	1n	2n

.PARAM STATE=0

.param	tr=0.1n	tf=0.1n	rate=5e8

** Simulation **

.op
.tran	0.01n	200N
.measure tran P_dyn	avg	i(vdd)

.option accurate=1

.end
