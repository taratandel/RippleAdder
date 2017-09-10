STATIC CMOS ADDER
**
* Author: tara Tandel (tara.tandel.94@gmail.com)
* Create Date: 28-08-2015
* File Name: STATIC_CMOS_ADDER_timing.sp
**

.param	Vsup=1.2

.protect

.SUBCKT FA A B CI S CO DD 0

.lib './32nm_MGK.l'   

.param	Wmin=32n
.param	Lmin=32n

M01	n1	A	dd	dd	pmos	w='4*Wmin'	l=Lmin
M02	n1	B	dd	dd	pmos	w='4*Wmin'	l=Lmin

M03	n2	B	n1	dd	pmos	w='8*Wmin'	l=Lmin
M04	Co_not	A	n2	dd	pmos	w='8*Wmin'	l=Lmin
M05	Co_not	Ci	n1	dd	pmos	w='4*Wmin'	l=Lmin

M06	Co_not	Ci	n3	0	nmos	w='2*Wmin'	l=Lmin
M07	n3	A	0	0	nmos	w='2*Wmin'	l=Lmin
M08	n3	B	0	0	nmos	w='2*Wmin'	l=Lmin

M09	Co_not	A	n4	0	nmos	w='2*Wmin'	l=Lmin
M10	n4	b	0	0	nmos	w='2*Wmin'	l=Lmin


M11	n5	A	dd	dd	pmos	w='4*Wmin'	l=Lmin
M12	n5	B	dd	dd	pmos	w='4*Wmin'	l=Lmin
M13	n5	Ci	dd	dd	pmos	w='4*Wmin'	l=Lmin

M14	S_not	Co_not	n5	dd	pmos	w='4*Wmin'	l=Lmin
M15	n6	A	n5	dd	pmos	w='12*Wmin'	l=Lmin
M16	n7	B	n6	dd	pmos	w='12*Wmin'	l=Lmin
M17	S_not	Ci	n7	dd	pmos	w='12*Wmin'	l=Lmin


M18	S_not	Co_not	n8	0	nmos	w='2*Wmin'	l=Lmin
M19	n8	A	0	0	nmos	w='2*Wmin'	l=Lmin
M20	n8	B	0	0	nmos	w='2*Wmin'	l=Lmin
M21	n8	Ci	0	0	nmos	w='2*Wmin'	l=Lmin

M22	S_not	Ci	n9	0	nmos	w='3*Wmin'	l=Lmin
M23	n9	B	n10	0	nmos	w='3*Wmin'	l=Lmin
M24	n10	A	0	0	nmos	w='3*Wmin'	l=Lmin



M25	Co	Co_not	dd	dd	pmos	w='2*Wmin'	l=Lmin
M26	Co	Co_not	0	0	nmos	w=Wmin		l=Lmin

M27	S	S_not	dd	dd	pmos	w='2*Wmin'	l=Lmin
M28	S	S_not	0	0	nmos	w=Wmin		l=Lmin


.ends

.unprotect


X_FA0	A0	B0	C_in	S0	C0	DD	0	FA
X_FA1	A1	B1	C0	S1	C1	DD	0	FA
X_FA2	A2	B2	C1	S2	C2	DD	0	FA
X_FA3	A3	B3	C2	S3	C_Out	DD	0	FA

** Source **

vDD	dd	0	DC=Vsup

V_Cin	C_in	0	Pulse	0	Vsup	20p 1p 1p 200p 1000p

v_A0	A0	0	DC=0
v_A1	A1	0	DC=0
v_A2	A2	0	DC=0
v_A3	A3	0	DC=0

v_B0	B0	0	DC=1
v_B1	B1	0	DC=1
v_B2	B2	0	DC=1
v_B3	B3	0	DC=1

.PARAM STATE=Vsup


** Simulation **

.op
.tran	0.01p	300p
.measure tran P_dyn	avg	i(vdd)

.option accurate=1

.end
