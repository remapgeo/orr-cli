

class OrrValidationError(Exception):
    def __init__(self, mensagem):
        self.mensagem = mensagem

    def __str__(self):
        return self.mensagem


class OrrDictValidationError(Exception):
    def __init__(self, errors_dict):
        self.errors_dict = errors_dict
        
        error_messages = []
        if errors_dict['columns']['ausente']:
            error_messages.append('The following columns are missing: {}'.format(", ".join(errors_dict["columns"]["ausente"])))
        if errors_dict['columns']['excedente']:
            error_messages.append('The following columns are not allowed: {}'.format(", ".join(errors_dict["columns"]["excedente"])))
        if errors_dict['columns']['geometry']:
            error_messages.append('The following columns are not allowed: {}'.format(", ".join(errors_dict["columns"]["geometry"])))
        if errors_dict['rows']:
            error_messages.append('The following errors were found in the file:\n{}'.format(", ".join(errors_dict["rows"])))
        
        super().__init__("\n".join(error_messages))