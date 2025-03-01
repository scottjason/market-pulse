import sys
import os

# Ensure the app directory is in the Python path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from logging.config import fileConfig
from sqlalchemy import create_engine, pool
from alembic import context
from app.db.base import Base  # Import models after modifying sys.path
from app.core.config import DATABASE_URL


# Alembic Config object, which provides access to alembic.ini settings
config = context.config

# Ensure DATABASE_URL is correctly set
if not DATABASE_URL:
    raise ValueError(
        "DATABASE_URL is not set. Ensure the environment variables are loaded correctly."
    )

config.set_main_option("sqlalchemy.url", DATABASE_URL)

# Load logging configuration from alembic.ini if available
if config.config_file_name is not None:
    fileConfig(config.config_file_name)

# Define target metadata for Alembic autogeneration
target_metadata = Base.metadata

# Create engine explicitly using DATABASE_URL
connectable = create_engine(DATABASE_URL, poolclass=pool.NullPool)


def run_migrations_offline() -> None:
    """Run migrations in 'offline' mode (without DB connection)."""
    context.configure(
        url=DATABASE_URL,
        target_metadata=target_metadata,
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
    )

    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online() -> None:
    """Run migrations in 'online' mode (with DB connection)."""
    with connectable.connect() as connection:
        context.configure(connection=connection, target_metadata=target_metadata)

        with context.begin_transaction():
            context.run_migrations()


# Determine if Alembic should run online or offline migrations
if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()
