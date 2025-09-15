def add_prefix_un(word):
    return f"un{word}"


def make_word_groups(vocab_words):
    prefix = vocab_words.pop(0)
    prefixed = [prefix + w for w in vocab_words]
    return " :: ".join([prefix] + prefixed)


def remove_suffix_ness(word):
    match word.removesuffix("ness"):
        case w if w.endswith("i"):
            return w[:-1] + "y"
        case w:
            return w


def adjective_to_verb(sentence, index):
    split = sentence[:-1].split(" ")
    return split[index] + "en"
