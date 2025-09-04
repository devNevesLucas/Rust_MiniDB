local function verificar_cpf()


end

local function tratar_insert()

    if args[2]:find("^" .. "cpf") then
        print("CPF inserido!")
    end

end


print("ola!!!")

for i = 0, #arg do

    print("Argumento [" .. i .. "]: " .. arg[i])

end

if #arg < 3 then
    print("Quantidade de argumentos invalida")
    return -1
end

if args[1] == "GET" then
    print("Caiu no GET!\n")
elseif args[1] == "ADD" then
    print("Caio no ADD!\n")
    tratar_insert()
end



return 10
