app_configs = [
    'database_config',
]

DEV_APP_CONFIG = 'dev'
DEFAULT_APP_CONFIG = 'defaults'

for config in app_configs:
    try:
        exec('from brillick.config.{0}.{1} import *'.format(DEV_APP_CONFIG, config))
    except ImportError as e:
        print('WARNING:: Importing {0} as default config'.format(config))
        exec('from brillick.config.{0}.{1} import *'.format(DEFAULT_APP_CONFIG, config))
