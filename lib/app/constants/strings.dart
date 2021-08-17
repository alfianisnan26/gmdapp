enum Locale{
  ID, EN
}

class Strings {
  static Locale lang = Locale.ID;

  static String appName = {
    Locale.EN:'Village Teaching Movement - Sukabumi',
    Locale.ID:'Gerakan Mengajar Desa - Sukabumi'
  }[lang];

  static String signInMessage = {
    Locale.EN:'Please sign in',
    Locale.ID:'Mohon untuk masuk'
  }[lang];

  static String anonymousSignUp = {
    Locale.EN:'Anonymous sign in',
    Locale.ID:'Masuk sebagai tamu'
  }[lang];

  static String signOut = {
    Locale.EN:'Sign out',
    Locale.ID:'Keluar'
  }[lang];

  static String email = {
    Locale.EN:'Email',
    Locale.ID:'Email',
  }[lang];

  static String pass = {
    Locale.EN:'Password',
    Locale.ID:'Kata Sandi'
  }[lang];

  static String passConfirm = {
    Locale.EN:'Password Confirmation',
    Locale.ID:'Konfirmasi Kata Sandi'
  }[lang];

  static String signWithGoogle = {
    Locale.EN:"Sign in with Google",
    Locale.ID:"Masuk dengan Google"
  }[lang];

  static String login = {
    Locale.EN:"Login",
    Locale.ID:"Masuk"
  }[lang];

  static String errorCannotLogin ={
    Locale.EN:"Error! Cannot Login",
    Locale.ID:"Kesalahan! Tidak dapat masuk"
  }[lang];

  static String forgetPassword ={
    Locale.EN:"Forget password",
    Locale.ID:"Lupa kata sandi"
  }[lang];

  static String signup={
    Locale.EN:"Sign up",
    Locale.ID:"Daftar"
  }[lang];

  static String footer ={
    Locale.EN:"Created by Assigment Score Book Team, Division of Education and Development\nGerakan Mengajar Desa - Sukabumi © 2021",
    Locale.ID:"Dibuat oleh Tim Buku Penilaian, Divisi Edukasi dan Pengembangan\nGerakan Mengajar Desa - Sukabumi © 2021",
  }[lang];

  static String back = {
    Locale.EN:"Back",
    Locale.ID:"Kembali",
  }[lang];

  static String sendVerification = {
    Locale.EN:"Send Verification",
    Locale.ID:"Kirim Verifikasi",
  }[lang];

  static String errorEmailInvalid ={
    Locale.EN:"Email is invalid, please re-check your email",
    Locale.ID:"Email salah, mohon cek kembali email anda",
  }[lang];

  static String errorPasswordInvalid ={
    Locale.EN:"Password must have at least 8 character with a capital and a number",
    Locale.ID:"Kata sandi harus memiliki setidaknya 8 karakter dengan sebuah huruf kapital dan sebuah huruf"
  }[lang];

  static String errorPasswordDoesNotMatch={
    Locale.EN:"Password does not match, please re-check your password",
    Locale.ID:"Kata sandi tidak cocok, mohon cek kembali kata sandi anda",
  }[lang];

  static String errorCannotRegister={
    Locale.EN:"Error! Cannot register new account",
    Locale.ID:"Kesalahan! Tidak dapat registrasi"
  }[lang];

  static String emailAlreadyInUse={
    Locale.EN:"Error! Email already in use",
    Locale.ID:"Kesalahan! Alamat email telah teregistrasi"
  }[lang];

  static String emailNotVerified={
    Locale.EN:"Account is not verified, Please check your email",
    Locale.ID:"Akun anda belum terverifikasi, Mohon cek email anda"
  }[lang];

  static String resetEmailSent={
    Locale.EN:"Email has sent!, Check your email to reset the password",
    Locale.ID:"Email terkirim!, Mohon cek email anda untuk melakukan penggantian kata sandi"
  }[lang];

  static String userNotFound = {
    Locale.EN:"Error! User not found",
    Locale.ID:"Kesalahan! Pengguna tidak ditemukan"
  }[lang];
}