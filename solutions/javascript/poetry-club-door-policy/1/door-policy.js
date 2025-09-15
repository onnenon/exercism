export function frontDoorResponse(line) {
  return line.charAt(0);
}

export function frontDoorPassword(word) {
  return word[0].toUpperCase() + word.slice(1).toLowerCase();
}

export function backDoorResponse(line) {
  const trimmed = line.trim();
  return trimmed.charAt(trimmed.length - 1);
}

export function backDoorPassword(word) {
  return word[0].toUpperCase() + word.slice(1) + ", please";
}
