CVSL ADDER
**
* Author: tara Tandel (tara.tandel.94@gmail.com)
* Create Date: 28-08-2015
* File Name: CVSL_CMOS_ADDER.sp
**

.param	Vsup=1.2

.protect

.SUBCKT FA A B CI S CO DD 0

.lib './32nm_MGK.l'

.param	Wmin=32n
.param	Lmin=32n

M01	Co_not	Co	dd	dd	pmos	w='Wmin'	l=Lmin

M02	Co_not	Ci	n3	0	nmos	w='2*Wmin'	l=Lmin
M03	n3	A	0	0	nmos	w='2*Wmin'	l=Lmin
M04	n3	B	0	0	nmos	w='2*Wmin'	l=Lmin

M05	Co_not	A	n4	0	nmos	w='2*Wmin'	l=Lmin
M06	n4	B	0	0	nmos	w='2*Wmin'	l=Lmin


M07	Co	Co_not	dd	dd	pmos	w='Wmin'	l=Lmin

M08	Co	Ci_not	n1	0	nmos	w='2*Wmin'	l=Lmin
M09	Co	A_not	n5	0	nmos	w='4*Wmin'	l=Lmin
M10	n5	B_not	n1	0	nmos	w='4*Wmin'	l=Lmin

M11	n1	A_not	0	0	nmos	w='2*Wmin'	l=Lmin
M12	n1	B_not	0	0	nmos	w='2*Wmin'	l=Lmin




M113	S_not	S	dd	dd	pmos	w='Wmin'	l=Lmin

M14	S_not	Co_not	n6	0	nmos	w='2*Wmin'	l=Lmin
M15	n6	A	0	0	nmos	w='2*Wmin'	l=Lmin
M16	n6	B	0	0	nmos	w='2*Wmin'	l=Lmin
M17	n6	Ci	0	0	nmos	w='2*Wmin'	l=Lmin

M18	S_not	Ci	n9	0	nmos	w='3*Wmin'	l=Lmin
M19	n9	B	n10	0	nmos	w='3*Wmin'	l=Lmin
M20	n10	A	0	0	nmos	w='3*Wmin'	l=Lmin


M21	S	S_not	dd	dd	pmos	w='Wmin'	l=Lmin


M22	S	Co	n8	0	nmos	w='2*Wmin'	l=Lmin
M23	S	Ci_not	n11	0	nmos	w='6*Wmin'	l=Lmin
M24	n11	A_not	n12	0	nmos	w='6*Wmin'	l=Lmin
M25	n12	B_not	n8	0	nmos	w='6*Wmin'	l=Lmin

M26	n8	Ci_not	0	0	nmos	w='2*Wmin'	l=Lmin
M27	n8	B_not	0	0	nmos	w='2*Wmin'	l=Lmin
M28	n8	A_not	0	0	nmos	w='2*Wmin'	l=Lmin

M30	A_not	A	dd	dd	pmos	w='Wmin'	l=Lmin
M31	A_not	A	0	0	nmos	w=Wmin		l=Lmin

M32	B_not	B	dd	dd	pmos	w='2*Wmin'	l=Lmin
M33	B_not	B	0	0	nmos	w=Wmin		l=Lmin

M34	Ci_not	Ci	dd	dd	pmos	w='2*Wmin'	l=Lmin
M35	Ci_not	Ci	0	0	nmos	w=Wmin		l=Lmin






.ends

.unprotect


X_FA0	A0	B0	C_in	S0	C0	DD	0	FA
X_FA1	A1	B1	C0	S1	C1	DD	0	FA
X_FA2	A2	B2	C1	S2	C2	DD	0	FA
X_FA3	A3	B3	C2	S3	C_Out	DD	0	FA


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

.PARAM STATE=Vsup


.param	tr=0.1n	tf=0.1n	rate=10e8

** Simulation **

.op
.tran	0.01n	100N
.measure tran P_dyn	avg	i(vdd)

.option accurate=1

.end
