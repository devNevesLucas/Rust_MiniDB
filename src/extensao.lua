local function verificar_cpf()


end

local function formatar_cpf()

    return string.sub(arg[3], 1, 3) .. "." .. string.sub(arg[3], 4, 6) .. "." .. string.sub(arg[3], 7, 9) .. "-" .. string.sub(arg[3], 10, 11)

end

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

    if arg[2]:find("^" .. "cpf") then
        print("CPF inserido!")
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
]]--

local funcaoEnviada = string.upper(arg[1])

if funcaoEnviada == "GET" then

    return tratar_select()    

elseif funcaoEnviada == "ADD" then

    return tratar_insert()

else

    error("Função enviada é inválida!")

end