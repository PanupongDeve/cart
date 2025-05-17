use actix_web::{get, App, HttpServer, Responder};

#[get("/")]
async fn hello() -> impl Responder {
   format!("Hello World!")
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