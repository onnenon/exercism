def capitalize_title(title: str):
    return title.title()


def check_sentence_ending(sentence: str):
    return sentence.endswith(".")


def clean_up_spacing(sentence: str):
    return sentence.strip()


def replace_word_choice(sentence: str, old_word: str, new_word: str):
    return sentence.replace(old_word, new_word)
