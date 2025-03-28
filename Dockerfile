
FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*


# install libraries using pip
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN python3 -m pip install --upgrade pip && \
    pip3 install -r requirements.txt

# Copy the entire project into the container
COPY . /app

# Expose port 8000 so the container is accessible
EXPOSE 8000

# Set an environment variable for the Django settings module
ENV DJANGO_SETTINGS_MODULE=ffxiv_workshop_companion.settings

# Run database migrations and then start the Django development server
CMD python3 manage.py migrate && python3 manage.py runserver 0.0.0.0:8000
