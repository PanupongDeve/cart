use actix_web::{get, App, HttpServer, Responder};

#[get("/")]
async fn hello() -> impl Responder {
   let hello_message = env::var("HELLO_MESSAGE").unwrap_or("unknown".to_string());
   format!("Hi, {}!", hello_message)
}

#[actix_web::main] // or #[tokio::main]
async fn main() -> std::io::Result<()> {
   HttpServer::new(|| {
       App::new().service(hello)
   })
   .bind(("0.0.0.0", 9000))?
   .run()
   .await
}