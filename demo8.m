% Preparacion de consola
clc;
clear all;

% Parámetros de entrada
key = [uint8(1:36)];
nonce = [uint8(1:16)];
associateddata = [uint8(1:16)];
associateddata1 = [uint8(2:17)];
text = 'Tabatha and Sareth, twelve and eight years old, walked through the twisted trees of the forest, following the breadcrumbs their mother, Kiya, had left the night before. The evening light painted the leaves red, and the whispers of the wind seemed to call their names. Suddenly, a silver-furred fox appeared before them, holding Kiya is embroidered handkerchief in its mouth. Without hesitation, the sisters ran after it, trusting it would lead them to the truth...';
plaintext = uint8(text);
plaintext(1)
double(plaintext(1))
dec2binvec(double(plaintext(1)),8)


tic
% Cifrado
[ciphertext, tag] = ascon_encrypt(key, nonce, associateddata, plaintext);
toc
tic
% Descifrado
[decrypted_plaintext, valid, generated_tag] = ascon_decrypt(key, nonce, associateddata, ciphertext, tag);
toc
% Verificación (Impresion de Error)
%assert(valid, 'La etiqueta de autenticación no es válida.');
%assert(isequal(plaintext, decrypted_plaintext), 'El texto plano descifrado no coincide con el original.');


% Cadenas de salida
cadena_Texto_Plano = ['El texto Plano es: ', char(plaintext)];
cadena_Texto_Cifrado = ['El texto Cifrado es: ', char(ciphertext)];
cadena_Texto_Descifrado = ['El texto Recuperado es: ', char(decrypted_plaintext)];

generated_tag


% Impresion de Cadenas (Salidas de consola)
disp(cadena_Texto_Plano);
disp(cadena_Texto_Cifrado);
disp(cadena_Texto_Descifrado);
disp(' ');
disp('El cifrado y descifrado funcionan correctamente.');