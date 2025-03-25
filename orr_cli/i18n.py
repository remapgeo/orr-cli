import glob
import json
import os
from string import Template

import yaml

from orr_cli.config import ROOT_DIR
from orr_cli.logger import logger
supported_format = ["json", "yaml"]
from locale import getlocale


class Translator:
    def __init__(self, translations_folder="locale/", file_format="json", lang=None):
        # initialization
        self.data = {}
        if None is lang:
            locale_now = getlocale()[0]
            if locale_now in ["pt_BR", "en_US"]:
                self.locale = locale_now
            else:
                self.locale = "pt_BR"

        # check if format is supported
        if file_format in supported_format:
            # get list of files with specific extensions
            files = glob.glob(
                os.path.join(f"{ROOT_DIR}/{translations_folder}", f"*.{file_format}")
            )

            for fil in files:
                # get the name of the file without extension, will be used as locale name
                loc = os.path.splitext(os.path.basename(fil))[0]
                with open(fil, "r", encoding="utf8") as f:
                    if file_format == "json":
                        self.data[loc] = json.load(f)
                    elif file_format == "yaml":
                        self.data[loc] = yaml.safe_load(f)

    def set_locale(self, loc):
        if loc in self.data:
            self.locale = loc
        else:
            logger.error("Invalid locale")

    def get_locale(self):
        return self.locale

    def translate(self, key, **kwargs):
        # return the key instead of translation text if locale is not supported
        if self.locale not in self.data:
            return key

        text = self.data[self.locale].get(key, key)
        # type dict represents key with plural form
        if type(text) == dict:
            count = kwargs.get("count", 1)
            # parse count to int
            try:
                count = int(count)
            except Exception:
                logger.error("Invalid count")
                return key

        return Template(text).safe_substitute(**kwargs)
