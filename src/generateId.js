import { customAlphabet } from "nanoid";

const firebaseAlphabet =
  "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
const ID_LENGTH = 28;

const nanoid = customAlphabet(firebaseAlphabet, ID_LENGTH);

export function generateId() {
  const id = nanoid();
  return id;
}
