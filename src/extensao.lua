local function split(str, pattern)

    particoes = {}

    local posicaoAtual = 1
    local ultimaPosicao = 1

    while posicaoAtual <= #str do

        local inicioPattern, finalPattern = string.find(str, pattern, posicaoAtual)

        if inicioPattern == nil then
            break
        end

        local subStr = str:sub(ultimaPosicao, inicioPattern - 1)

        if finalPattern < #str then
            posicaoAtual = finalPattern + 1            

        else
            posicaoAtual = finalPattern
        end

            ultimaPosicao = posicaoAtual

        table.insert(particoes, subStr)
    end

    local subStrFinal = str:sub(ultimaPosicao, #str)

    table.insert(particoes, subStrFinal)

    return particoes

end

local function verificar_cpf()

    local soma = 0

    for i = 10, 2, -1 do

        local posicaoAtual = math.abs(i - 11)

        local digitoAtual = arg[3]:sub(posicaoAtual, posicaoAtual)

        digitoAtualInt = tonumber(digitoAtual)

        soma = soma + (digitoAtualInt * i)        
    end

    local resto = soma % 11
    local primeiroVerificador = 11 - resto

    if tostring(primeiroVerificador) ~= arg[3]:sub(10, 10) then
        error("CPF inválido: Verifique o primeiro digito verificador!")
    end

    soma = 0

    for i = 10, 2, -1 do

        local posicaoAtual = math.abs(i - 12)

        local digitoAtual = arg[3]:sub(posicaoAtual, posicaoAtual)

        digitoAtualInt = tonumber(digitoAtual)

        soma = soma + (digitoAtualInt * i)
    end

    resto = soma % 11
    local segundoVerificador = 11 - resto

    if tostring(segundoVerificador) ~= arg[3]:sub(11, 11) then
        error("CPF inválido: Verifique o segundo digito verificador!")
    end

    return true
end

local function formatar_cpf()

    return string.sub(arg[3], 1, 3) .. "." .. string.sub(arg[3], 4, 6) .. "." .. string.sub(arg[3], 7, 9) .. "-" .. string.sub(arg[3], 10, 11)

end

local function verificar_data()

    if #arg[3] ~= 10 then
        error("Formato da data invalido!")
    end

    local dataDividida = split(arg[3], "-")

    if #dataDividida ~= 3 then
        error("Formato da data esta invalido!")
    end

    if #dataDividida[1] ~= 4 then
        error("Data com formato inválido: Ano deve ter 4 caracteres!")
    end
    
    if #dataDividida[2] ~= 2 then
        error("Data com formato inválido: Mês deve ter 2 caracteres!")
    end

    local mesNumerico = tonumber(dataDividida[2])

    if mesNumerico then
        if mesNumerico < 1 or mesNumerico > 12 then
            error("Data com formato inválido: Verifique o mês inserido!")
        end
    else
        error("Data com formato inválido: Verifique o mês inserido!")
    end

    if #dataDividida[3] ~= 2 then
        error("Data com formato inválido: Dia deve ter 2 caracteres!")
    end

    local diaNumerico = tonumber(dataDividida[3])

    if diaNumerico then
        if diaNumerico < 1 or diaNumerico > 31 then
            error("Data com formato inválido: Verifique o dia inserido!")
        end
    else
        error("Data com formato inválido: Verifique o dia inserido!")
    end

    print("Data valida!")

    return true

end

local function formatar_data()

    local dataDividida = split(arg[3], "-")

    print(dataDividida[3] .. "/" .. dataDividida[2] .. "/" .. dataDividida[1])

    return dataDividida[3] .. "/" .. dataDividida[2] .. "/" .. dataDividida[1]

end

local function tratar_select()

    if arg[2] == nil then
        error("Tipo de dado não foi inserido!")
    elseif arg[3] == nil then
        error("Dado a ser formatado não foi inserido!")
    end

    local dadoEnviado = string.upper(arg[2])

    if dadoEnviado == "CPF" then   

        return formatar_cpf()

    elseif dadoEnviado == "DATA" then

        return formatar_data()

    else
        error("Tipo de dado não foi inserido!")
    end

end

local function tratar_insert()

    if arg[2] == nil then
        error("Tipo de dado não foi inserido!")
    elseif arg[3] == nil then
        error("Dado a ser formatado não foi inserido!")
    end

    local dadoEnviado = string.upper(arg[2])

    if dadoEnviado == "CPF" then

        return verificar_cpf()

    elseif dadoEnviado == "DATA" then

        return verificar_data()
    
    else
        error("Tipo de dado não foi inserido")
    end
end

--[[
    Estrutura montada:
        Programa espera receber:
        função no primeiro argumento, 
        tipo de documento no segundo argumento,
        dado a ser tratado no terceiro argumento

    Exemplo: get cpf 13423412411
    Exemplo: add cpf 23412312312
    Exemplo: get data 2025-09-06
    Exemplo: add data 2025-09-06
]]--

local funcaoEnviada = string.upper(arg[1])

if funcaoEnviada == "GET" then

    return tratar_select()    

elseif funcaoEnviada == "ADD" then

    return tratar_insert()

else

    error("Função enviada é inválida!")

end