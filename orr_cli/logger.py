import os
import sys

from loguru import logger


def start_logger():
    type_logger = 'development'
    if os.environ.get('ORR_ENV') == 'production':
        type_logger = 'production'
    logger.info(f'The system is operating in mode {type_logger}')


confi_format = '[ {time} | process: {process.id} | {level: <8}] {module}.{function}:{line} {message}'
rotation = '500 MB'


if os.environ.get('ORR_ENV','production') == 'production':
    logger.remove()
    logger.add(sys.stderr, level='INFO', format=confi_format)

try:
    logger.add(
        '/logs/orr/orr-cli.log', rotation=rotation, level='INFO'
    )
except:
    logger.add(
        './logs/orr/orr-cli.log',
        rotation=rotation,
        level='INFO',
    )
try:
    logger.add(
        '/logs/orr/orr-cli_WARNING.log',
        level='WARNING',
        rotation=rotation,
    )
except:
    logger.add(
        './logs/orr/orr-cli_WARNING.log',
        level='WARNING',
        rotation=rotation,
    )