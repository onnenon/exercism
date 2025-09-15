const aminos = {
  AUG: "Methionine",
  UUU: "Phenylalanine",
  UUC: "Phenylalanine",
  UUA: "Leucine",
  UUG: "Leucine",
  UCU: "Serine",
  UCC: "Serine",
  UCA: "Serine",
  UCG: "Serine",
  UAU: "Tyrosine",
  UAC: "Tyrosine",
  UGU: "Cysteine",
  UGC: "Cysteine",
  UGG: "Tryptophan",
  UAA: "STOP",
  UAG: "STOP",
  UGA: "STOP",
};

export const translate = (sequence = "") => {
  if (!sequence) return [];

  const proteins = [];

  for (let i = 0; i < sequence.length; i += 3) {
    if (i + 3 > sequence.length) {
      if (!["UAA", "UAG", "UGA"].some((stop) => sequence.includes(stop))) {
        throw new Error("Invalid codon");
      }
      break;
    }

    const codon = sequence.slice(i, i + 3);
    const protein = aminos[codon];

    if (!protein) {
      throw new Error("Invalid codon");
    }

    if (protein === "STOP") {
      break;
    }

    proteins.push(protein);
  }

  return proteins;
};
