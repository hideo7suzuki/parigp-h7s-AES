Readme.md of parigp-h7s-AES/h7s-AES.gp

This program is for PARI/GP, not for Gnuplot.

[in English]  
program lists of AES (128 bit key) encryption/decryption programs using PARI/GP ver.0.900.  
copyright by Hideo Suzuki, hideo7suzuki@gmail.com  Jan. 2025.  

AES_RK(KEY) generation of AES round keys RK[1-11]  
AES(PT,KEY) AES encryption  
AESinv(CT,KEY) AES decryption (=inv)  
AESprintRK() print of AES round keys RKs  
AESprint() print of AES KEY, PT(plaintext), CT(ciphertext)  
AESprintrev() print of AES KEY, PT(plaintext), CT(ciphertext) in reverse order  
AESprintKEY() print of AES KEY  
AESprintPT() print of AES PT(plaintext)  
AESprintCT() print of AES CT(ciphertext)  
AESprintCTT() print of AES CTTs (ciphertext in each round)  
AESprintCTTrev() print of AES CTTs (ciphertext in each round) in reverse order  

program lists of AES (128 bit key) encryption/decryption internal programs using PARI/GP ver.0.900.  
copyright by Hideo Suzuki, hideo7suzuki@gmail.com  Jan. 2025.  

AESnextRK(RK,RC) generation of AES next round key  
AES_round(r,A) processing of AES encryption in each round  
AES_round10(r,A) processing of AES encryption at the 10th round  
AESinv_round(r,C) processing of AES decryption in each round  
AESinv_round10(r,C) AES processing of AES decryption at the 10th round  

----------

Rules in these programs:  
key should be set to the variable KEY.  
plaintext should be set to the variable PT.  
ciphertext should be set to the variable CT.  

Execution example:  
(input)  
KEY=0x000102030405060708090A0B0C0D0E0F;  
AES_RK(KEY);  
AESprintRK()  
(output)  
   KEY=0x000102030405060708090A0B0C0D0E0F  
RK[ 1]=0x000102030405060708090A0B0C0D0E0F  
RK[ 2]=0xD6AA74FDD2AF72FADAA678F1D6AB76FE  
RK[ 3]=0xB692CF0B643DBDF1BE9BC5006830B3FE  
RK[ 4]=0xB6FF744ED2C2C9BF6C590CBF0469BF41  
RK[ 5]=0x47F7F7BC95353E03F96C32BCFD058DFD  
RK[ 6]=0x3CAAA3E8A99F9DEB50F3AF57ADF622AA  
RK[ 7]=0x5E390F7DF7A69296A7553DC10AA31F6B  
RK[ 8]=0x14F9701AE35FE28C440ADF4D4EA9C026  
RK[ 9]=0x47438735A41C65B9E016BAF4AEBF7AD2  
RK[10]=0x549932D1F08557681093ED9CBE2C974E  
RK[11]=0x13111D7FE3944A17F307A78B4D2B30C5  

(input)  
PT=0x00112233445566778899AABBCCDDEEFF;  
CT = AES(PT,KEY);  
AESprint()  
(output)  
(dec)  
KEY=5233100606242806050955395731361295  
 PT=88962710306127702866241727433142015  
 CT=140591190147677442632770771134392354138  
(hexdec)  
KEY=0x000102030405060708090A0B0C0D0E0F  
 PT=0x00112233445566778899AABBCCDDEEFF  
 CT=0x69C4E0D86A7B0430D8CDB78070B4C55A  

(input)  
AESprintCTT()  
(output)  
     PT=0x00112233445566778899AABBCCDDEEFF  
CTT[ 1]=0x00102030405060708090A0B0C0D0E0F0  
CTT[ 2]=0x89D810E8855ACE682D1843D8CB128FE4  
CTT[ 3]=0x4915598F55E5D7A0DACA94FA1F0A63F7  
CTT[ 4]=0xFA636A2825B339C940668A3157244D17  
CTT[ 5]=0x247240236966B3FA6ED2753288425B6C  
CTT[ 6]=0xC81677BC9B7AC93B25027992B0261996  
CTT[ 7]=0xC62FE109F75EEDC3CC79395D84F9CF5D  
CTT[ 8]=0xD1876C0F79C4300AB45594ADD66FF41F  
CTT[ 9]=0xFDE3BAD205E5D0D73547964EF1FE37F1  
CTT[10]=0xBD6E7C3DF2B5779E0B61216E8B10B689  
CTT[11]=0x69C4E0D86A7B0430D8CDB78070B4C55A  
     CT=0x69C4E0D86A7B0430D8CDB78070B4C55A  

(input)  
CT=0x69C4E0D86A7B0430D8CDB78070B4C55A;  
PT = AESinv(CT,KEY);  
AESprintrev()  
(output)  
(dec)  
KEY=5233100606242806050955395731361295  
 CT=140591190147677442632770771134392354138  
 PT=88962710306127702866241727433142015  
(hexdec)  
KEY=0x000102030405060708090A0B0C0D0E0F  
 CT=0x69C4E0D86A7B0430D8CDB78070B4C55A  
 PT=0x00112233445566778899AABBCCDDEEFF  

(input)  
AESprintCTTrev()  
(output)  
     CT=0x69C4E0D86A7B0430D8CDB78070B4C55A  
CTT[11]=0x69C4E0D86A7B0430D8CDB78070B4C55A  
CTT[10]=0xBD6E7C3DF2B5779E0B61216E8B10B689  
CTT[ 9]=0xFDE3BAD205E5D0D73547964EF1FE37F1  
CTT[ 8]=0xD1876C0F79C4300AB45594ADD66FF41F  
CTT[ 7]=0xC62FE109F75EEDC3CC79395D84F9CF5D  
CTT[ 6]=0xC81677BC9B7AC93B25027992B0261996  
CTT[ 5]=0x247240236966B3FA6ED2753288425B6C  
CTT[ 4]=0xFA636A2825B339C940668A3157244D17  
CTT[ 3]=0x4915598F55E5D7A0DACA94FA1F0A63F7  
CTT[ 2]=0x89D810E8855ACE682D1843D8CB128FE4  
CTT[ 1]=0x00102030405060708090A0B0C0D0E0F0  
     PT=0x00112233445566778899AABBCCDDEEFF  

----------

[in Japanese]  
AES暗号 (128 bit key) ユーザ定義関数プログラムリスト  
copyright by Hideo Suzuki, hideo7suzuki@gmail.com  Jan. 2025.  

AES_RK(KEY) AES 暗号のラウンド鍵RK[1-11] 生成関数  
AES(PT,KEY) AES 暗号化関数  
AESinv(CT,KEY) AES 復号(inv) 関数  
AESprintRK() AES 暗号のラウンド鍵RK のprint 関数  
AESprint() AES 暗号のKEY(鍵).PT(平文),CT(暗号文) のprint 関数  
AESprintrev() AES 暗号のKEY(鍵),CT(暗号文).PT(平文) のprint 関数, 逆順(rev)  
AESprintKEY() AES 暗号のKEY(鍵) のprint 関数  
AESprintPT() AES 暗号のPT(平文) のprint 関数  
AESprintCT() AES 暗号のCT(暗号文) のprint 関数  
AESprintCTT() AES 暗号のCTT(暗号文の途中経過) のprint 関数  
AESprintCTTrev() AES 暗号のCTT(暗号文の途中経過) のprint 関数, 逆順(rev)  

AES 暗号化・復号の内部処理関数  
copyright by Hideo Suzuki, hideo7suzuki@gmail.com  Jan. 2025.  

AESnextRK(RK,RC) AES 暗号の次のラウンド鍵RK 計算関数  
AES_round(r,A) AES 暗号のラウンド暗号化処理関数  
AES_round10(r,A) AES 暗号のラウンド10 暗号化処理関数  
AESinv_round(r,C) AES 暗号のラウンドの復号(inv) 処理関数  
AESinv_round10(r,C) AES 暗号のラウンド10 の復号(inv) 処理関数  

----------

このプログラムの規則:  
鍵, 平文, 暗号文の各変数は, KEY, PT, CT とする.  

実行例は [in English] の Execution example と同じ.  
   
----------
