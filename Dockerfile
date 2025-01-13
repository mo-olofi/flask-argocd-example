# Use the official Python image from the Docker Hub
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY app/requirements.txt .
COPY app/requirements-dev.txt .

# Install the required dependencies
ARG ENV=prod
RUN if [ "$ENV" = "dev" ]; then \
        pip install --no-cache-dir -r requirements-dev.txt; \
    else \
        pip install --no-cache-dir -r requirements.txt; \
    fi

# Copy the rest of the application code into the container
COPY app/ .

# Expose port 5001 to the outside world
EXPOSE 5001

# Define the command to run the application
CMD ["python", "app.py"]