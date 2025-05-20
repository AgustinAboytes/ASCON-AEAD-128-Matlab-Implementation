function [plaintext, valid, generated_tag] = ascon_decrypt(key, nonce, associateddata, ciphertext, tag)
    % Inicializar el estado
    S = ascon_initialize(key, nonce);
    
%     disp('Primera S de Dec: ')
%     disp(S)

    % Procesar los datos asociados
    S = ascon_process_associated_data(S, associateddata);
    
%     disp('Segunda S de Dec: ')
%     disp(S)

    % Procesar el texto cifrado
    [S, plaintext] = ascon_process_ciphertext(S, ciphertext);
    
%     disp('Tercer S de Dec: ')
%     disp(S)

    % Finalizar el procesamiento y verificar la etiqueta
    %generated_tag = ascon_finalize_dec(S2, key);
    generated_tag = ascon_finalize(S, key);

    % Verificar la validez de la etiqueta
    valid = isequal(tag, generated_tag);
end