use std::{collections::HashMap, fs, io::{self}};
use mlua::prelude::*;
use mlua::Chunk;

fn obter_script<'lua>(lua: &'lua Lua, metodo: &str, chave: &str, valor: &str) -> Chunk<'lua>{

    let split_chave: Vec<&str> = chave.split("_").collect();

    let script = fs::read_to_string("src/extensao.lua").expect("Erro ao ler arquivo");

    let globals = lua.globals();

    globals.set("arg", [metodo, split_chave[0], valor]).unwrap();

    return lua.load(script);
}

fn verificar_insert(chave: &str, valor: &str) -> bool {

    let split_chave: Vec<&str> = chave.split("_").collect();

    let lua = Lua::new();

    match obter_script(&lua, "add", split_chave[0], valor).eval::<bool>() {
        Ok(retorno) => {            
            return retorno;
        }
        Err(problema) => {
            println!("Caiu no erro: {}", problema.to_string());
            return false;
        }
    };
}

fn realizar_insert(mut database: HashMap<String, String>, chave: &str, valor: &str) -> HashMap<String, String> {

    database.insert(chave.to_string(), valor.to_string());

    return database;
}

fn tratar_select(database: HashMap<String, String>, chave: &str) -> HashMap<String, String>{
    
    if !database.contains_key(chave) {
        println!("A chave {} não existe!", chave);
        return database;
    }

    let valor_obtido = match database.get(chave) {
        Some(valor) => {
            valor.to_string()
        },
        None => {
            println!("Item não encontrado!");
            return database;
        }
    };

    let lua = Lua::new();

    match obter_script(&lua,"get", chave, &valor_obtido).eval::<String>() {
        Ok(resultado_tratado) => {
            println!("GET {} => {}", chave, resultado_tratado);
        }
        Err(error) => {
            println!("Erro encontrado!");
            println!("{}", error.to_string());
        }
    }

    return database;
}

fn main() {
    println!("Hello, world!");

    let mut database: HashMap<String, String> = HashMap::new();

    let mut input_teclado = String::new();

    loop {
        println!("Digite o comando:");

        input_teclado.clear();

        io::stdin().read_line(&mut input_teclado)
            .expect("Erro lendo entrada");

        let input_tratado = input_teclado.trim();
        
        let input_split: Vec<&str> = input_tratado.split(' ').collect();

        match input_split[0] {
            "SAIR" => {
                println!("Saindo...");
                break;
            }
            "ADD" => {
                let resultado = verificar_insert(input_split[1], input_split[2]);

                if resultado {
                    database = realizar_insert(database, input_split[1], input_split[2]);

                } else {
                    println!("Chave {} não inserida!", input_split[1]);
                }

            }
            "GET" => {
                database = tratar_select(database, input_split[1]);
            }
            _ => {
                println!("Digite um comando válido");
            }
        }
    }
}
