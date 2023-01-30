# Use an official Python image as the base image
FROM python:3.10

# Set the working directory in the container
WORKDIR /openaichat

# Copy the requirements.txt file to the container
COPY requirements.txt .

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt

# Set an environment variable
ENV OPENAI_API_KEY=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

# Copy the rest of the application code to the container
COPY . .

# Set the default command to run when the container starts
CMD ["python", "app.py"]
