use std::{collections::HashMap, io::{self}};

fn tratar_insert(database: HashMap<String, String>, chave: &str, valor: &str) -> HashMap<String, String> {
    println!("chave: {}, valor: {}", chave, valor);

    return database;
}

fn tratar_select(database: HashMap<String, String>, chave: &str, valor: &str) -> HashMap<String, String>{
    println!("chave: {}, valor: {}", chave, valor);

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
                database = tratar_insert(database, input_split[1], input_split[2]);
            }
            "GET" => {
                database = tratar_select(database, input_split[1], input_split[2]);
            }
            _ => {
                println!("Digite um comando válido");
            }
        }
    }
}
