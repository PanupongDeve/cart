# 🚀 Welcome to the World of Rust! 🌟

Get ready to explore the power and performance of **Rust**, a systems programming language known for its safety, speed, and concurrency!

This is not just another "Hello, World!"—it’s your first step into the world of Rust programming. 💻🔥

---

## 🛠️ Prerequisites

Before running your first Rust program, make sure you have **Rust** installed on your system.

---

### 📦 Installing Rust

1. **Download and Install Rust:**

   Rust is an efficient, compiled language that gives you full control over system resources. To install Rust, follow these steps:

   - **For macOS/Linux:**
     Open your terminal and run:
     ```bash
     curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
     ```

     Follow the on-screen instructions, and then restart your terminal.

   - **For Windows Users:**
     Download and run the installer from [Rust's official website](https://www.rust-lang.org/tools/install).

2. **Verify Installation:**

   After installation, verify Rust is successfully installed by running:
   ```bash
   rustc --version
   ```
### 💡 Getting Started with a Web Server in Rust

To run your Rust "Hello, World!" program, follow these steps:

🧑‍💻 **Run the App with manual setup:**

   1. **Navigate to the Project Folder:**
      Open a terminal (or Command Prompt) and go to the directory where your `main.rs` file is located:
      ```bash
      cd path/to/your/project
      ```
   2. **Adding a dependency Using `cargo`:**
      To add the `actix-web` dependency to your project, run:
      ```bash
      cargo add actix-web
      ```
   3. **Run the Server Using `cargo`:**
      To start your Express server, use the following command:
      ```bash
      cargo run
      ```
      You should see the output:
      ```
      Finished `dev` profile [unoptimized + debuginfo] target(s) in 0.18s
      Running `target/debug/rust`
      ``` 
   
   3. **View in Your Browser:**
      Open your browser and navigate to:
      ```bash
      http://localhost:9000
      ```
      You should see the output:
      ```
      Hello, World!
      ```

🐳 **Run the App with Docker:**

   1. **Navigate to the Folder Containing the Dockerfile:**
      Open a terminal (or Command Prompt) and go to the directory where your `Dockerfile` is located:
      ```bash
      cd path/to/your/project
      ```

   2. **Building the Docker Image:**
      Run the following command to build your Docker image:

      ```bash
      docker build -t rust-web-app .
      ```

   4. **Running the Docker Container:**
      After building the image, run the following command to start the app in a Docker container:

      ```bash
      docker run -d -p 9000:9000 rust-web-app
      ```

   5. **Verify the Docker Container is Running:**
      To ensure that the Docker container is running, use the following command to list all running containers:

      ```bash
      docker ps
      ```

      This should show your container with the `rust-web-app` image running on port 9000. You should see something similar to this:
      ```
      CONTAINER ID   IMAGE          COMMAND                    CREATED          STATUS          PORTS                    NAMES
      abcdef123456   rust-web-app   "./target/release/ru.."    5 seconds ago    Up 4 seconds    0.0.0.0:9000->9000/tcp   cool_app
      ```

   6. **View in Your Browser:**
      Open your browser and navigate to:
      ```bash
      http://localhost:9000
      ```
      You should see the output:
      ```
      Hello, World!
      ```