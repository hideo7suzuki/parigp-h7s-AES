Readme.txt

[in English]

program lists of AES (128 bit key) encryption/decryption programs using PARI/GP ver.0.900.

copyright by Hideo Suzuki, hideo7suzuki@gmail.com  Jan. 2025.


AES_RK(KEY) generation of AES round keys RK

AES(PT,KEY) AES encryption

AESinv(CT,KEY) AES decryption (=inv)
AESprintRK() print of AES round keys RK
AESprint() print of AES KEY, PT(plaintext), CT(ciphertext)
AESprintrev() print of AES KEY, PT(plaintext), CT(ciphertext) in reverse order
AESprintKEY() print of AES KEY
AESprintPT() print of AES PT(plaintext)
AESprintCT() print of AES CT(ciphertext)
AESprintCTT() print of AES CTTs (ciphertext in each round)
AESprintCTTrev() print of AES CTTs (ciphertext in each round) in reverse order

AES 暗号化・復号の内部処理関数
program lists of AES (128 bit key) encryption/decryption internal programs using PARI/GP ver.0.900.
copyright by Hideo Suzuki, hideo7suzuki@gmail.com  Jan. 2025.

AESnextRK(RK,RC) generation of AES next round key
AES_round(r,A) processing of AES encryption in each round
AES_round10(r,A) processing of AES encryption at the 10th round
AESinv_round(r,C) processing of AES decryption in each round
AESinv_round10(r,C) AES processing of AES decryption at the 10th round

----------

[in Japanese]
AES暗号 (128 bit key) ユーザ定義関数プログラムリスト
copyright by Hideo Suzuki, hideo7suzuki@gmail.com  Jan. 2025.

AES_RK(KEY) AES 暗号のラウンド鍵RK 生成関数
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
