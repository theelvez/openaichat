# Use an official Python image as the base image
FROM python:3.10

# Set the working directory in the container
WORKDIR /openaichat

# Copy the requirements.txt file to the container
COPY requirements.txt .

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt

# Install OpenSSH service
RUN apt-get update && apt-get install -y openssh-server

# Set an environment variable
ENV OA_K_1=wl4J37aI31QgPqFc4F1tT3
ENV OA_K_2=BlbkFJgGPkvaw5JUWVf3J6jZev

# Copy the rest of the application code to the container
COPY . .

# Create the bash shell script that the ENTRYPOINT command refers to
#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh

CMD ["python", "app.py"]

# Set the default command to run when the container starts
#ENTRYPOINT ["/usr/bin/entrypoint.sh"