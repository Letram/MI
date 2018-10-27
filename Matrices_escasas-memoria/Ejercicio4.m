function Test_Struct
    x = rand(1000000, 1);
    tic;
    x = f_Ok(x);
    toc;
    data.x = x;
    tic;
    data = f_NOk(data);
    toc;
    
    whos;
end
function x = f_Ok(x)
    x(50) = 1;
end
function data = f_NOk(data)
    data.x(50) = 1; % Seproduce una reserva de espacio para la variable data
end

%Aunque la operación es la misma, el tiempo de acceso a memoria de una
%variable normal (x) es mucho menor que el tiempo de acceso a memoria de
%una variable de tipo struct compuesta (data es una estructura con una
%propiedad que se llama data.x). Los accesos a memoria en estos tipos de
%objetos son mucho más largos.