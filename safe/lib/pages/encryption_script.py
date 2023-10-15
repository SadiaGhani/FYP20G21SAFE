# import os
# from Crypto.Cipher import AES
# from Crypto.Random import get_random_bytes
# from Crypto.Protocol.KDF import PBKDF2
# from Crypto.Util.Padding import pad
# from base64 import b64encode, base64

# def generate_key(password, salt):
#     key = PBKDF2(password, salt, dkLen=32, count=1000000)
#     return key

# def encrypt_file_in_place(file_path, password):
#     salt = get_random_bytes(16)
#     key = generate_key(password, salt)
#     cipher = AES.new(key, AES.MODE_GCM)

#     with open(file_path, 'rb') as file:
#         plaintext = file.read()
#         ciphertext, tag = cipher.encrypt_and_digest(plaintext)

#     with open(file_path, 'wb') as encrypted_file:
#         encrypted_file.write(salt)
#         encrypted_file.write(cipher.nonce)
#         encrypted_file.write(ciphertext)
#         encrypted_file.write(tag)

# def main():
#     # Replace these with your own values
#     file_path = 'path_to_your_selected_file'
#     password = 'your_password'

#     encrypt_file_in_place(file_path, password)
#     print(f'File encrypted and replaced with the original file')

# if __name__ == '__main__':
#     main()
