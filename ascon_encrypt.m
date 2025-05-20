function [ciphertext, tag] = ascon_encrypt(key, nonce, associateddata, plaintext)
    % Inicializar el estado
    S = ascon_initialize(key, nonce);
    
%     disp('Primer S de Cif: ')
%     disp(S)

    % Procesar los datos asociados
    S = ascon_process_associated_data(S, associateddata);
    
%     disp('Segunda S de Cif: ')
%     disp(S)

    % Procesar el texto plano
    [S, ciphertext] = ascon_process_plaintext(S, plaintext);
    
%     disp('Tercer S de Cif: ')
%     disp(S)

    % Finalizar el procesamiento y generar la etiqueta
    tag = ascon_finalize(S, key);
end