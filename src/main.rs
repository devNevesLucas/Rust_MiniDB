use std::io::{self};

fn main() {
    println!("Hello, world!");

    let mut input_teclado = String::new();

    loop {
        println!("Digite o comando:");

        input_teclado.clear();

        io::stdin().read_line(&mut input_teclado)
            .expect("Erro lendo entrada");

        let input_tratado = input_teclado.trim();

        match input_tratado {
            "SAIR" => {
                println!("Saindo...");
                break;
            }
            _ => {
                println!("Digite um comando válido");
            }
        }
    }
}
