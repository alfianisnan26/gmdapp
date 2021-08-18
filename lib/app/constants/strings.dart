enum Locale {
  ID,
  EN
}

class Strings {
  static Locale lang = Locale.ID;

  static String appName = {
    Locale.EN: 'Village Teaching Movement - Sukabumi',
    Locale.ID: 'Gerakan Mengajar Desa - Sukabumi'
  }[lang];

  static String signInMessage = {
    Locale.EN: 'Please sign in',
    Locale.ID: 'Mohon untuk masuk'
  }[lang];

  static String anonymousSignUp = {
    Locale.EN: 'Anonymous sign in',
    Locale.ID: 'Masuk sebagai tamu'
  }[lang];

  static String signOut = {
    Locale.EN: 'Sign out',
    Locale.ID: 'Keluar'
  }[lang];

  static String email = {
    Locale.EN: 'Email',
    Locale.ID: 'Email',
  }[lang];

  static String pass = {
    Locale.EN: 'Password',
    Locale.ID: 'Kata Sandi'
  }[lang];

  static String passConfirm = {
    Locale.EN: 'Password Confirmation',
    Locale.ID: 'Konfirmasi Kata Sandi'
  }[lang];

  static String signWithGoogle = {
    Locale.EN: "Sign in with Google",
    Locale.ID: "Masuk dengan Google"
  }[lang];

  static String login = {
    Locale.EN: "Login",
    Locale.ID: "Masuk"
  }[lang];

  static String errorCannotLogin = {
    Locale.EN: "Error! Cannot Login",
    Locale.ID: "Kesalahan! Tidak dapat masuk"
  }[lang];

  static String forgetPassword = {
    Locale.EN: "Forget password",
    Locale.ID: "Lupa kata sandi"
  }[lang];

  static String signup = {
    Locale.EN: "Sign up",
    Locale.ID: "Daftar"
  }[lang];

  static String footer = {
    Locale
        .EN: "Created by Assigment Score Book Team, Division of Education and Development\nGerakan Mengajar Desa - Sukabumi © 2021",
    Locale
        .ID: "Dibuat oleh Tim Buku Penilaian, Divisi Edukasi dan Pengembangan\nGerakan Mengajar Desa - Sukabumi © 2021",
  }[lang];

  static String back = {
    Locale.EN: "Back",
    Locale.ID: "Kembali"
  }[lang];

  static String sendVerification = {
    Locale.EN: "Verify",
    Locale.ID: "Verifikasi"
  }[lang];

  static String resendVerification = {
    Locale
        .EN: "Email Sent!. Please check your email's inbox and click the link to verify the account's email",
    Locale
        .ID: "Email Terkirim!. Mohon cek kotak masuk email anda dan kemudian klik link untuk mem-verifikasi email akun",
  }[lang];

  static String errorEmailInvalid = {
    Locale.EN: "Email is invalid, please re-check your email",
    Locale.ID: "Email salah, mohon cek kembali email anda"
  }[lang];

  static String errorPasswordInvalid = {
    Locale
        .EN: "Password must have at least 8 character with a capital and a number",
    Locale
        .ID: "Kata sandi harus memiliki setidaknya 8 karakter dengan sebuah huruf kapital dan sebuah huruf"
  }[lang];

  static String errorPasswordDoesNotMatch = {
    Locale.EN: "Password does not match, please re-check your password",
    Locale.ID: "Kata sandi tidak cocok, mohon cek kembali kata sandi anda"
  }[lang];

  static String errorCannotRegister = {
    Locale.EN: "Error!, Cannot register new account",
    Locale.ID: "Kesalahan!, Tidak dapat registrasi"
  }[lang];

  static String emailAlreadyInUse = {
    Locale.EN: "Error!, Email already in use",
    Locale.ID: "Kesalahan!, Alamat email telah teregistrasi"
  }[lang];

  static String emailNotVerified = {
    Locale.EN: "Account is not verified, Please verify first",
    Locale.ID: "Akun anda belum terverifikasi, Mohon verifikasi terlebih dahulu"
  }[lang];

  static String resetEmailSent = {
    Locale.EN: "Email has sent!, Check your email to reset the password",
    Locale
        .ID: "Email terkirim!, Mohon cek email anda untuk melakukan penggantian kata sandi"
  }[lang];

  static String userNotFound = {
    Locale.EN: "Error!, User not found",
    Locale.ID: "Kesalahan!, Pengguna tidak ditemukan"
  }[lang];

  static String errorCannotSendEmail = {
    Locale.EN: "Error!, Cannot send verification email",
    Locale.ID: "Kesalahan!, Tidak dapat mengirim email verifikasi"
  }[lang];

  static String unverifyInfo = {
    Locale
        .EN: "Your email's account are not verified. Please send an email verification",
    Locale
        .ID: "Email akun anda belum terverifikasi. Mohon untuk mengirimkan email verifikasi"
  }[lang];

  static String verify = {
    Locale.EN: "Verify",
    Locale.ID: "Verifikasi"
  }[lang];

  static String emailVerified = {
    Locale.EN: "Email verified",
    Locale.ID: "Email terverifikasi"
  }[lang];

  static String waitToVerify = {
    Locale.EN: "Waiting for verification",
    Locale.ID: "Menunggu verifikasi"
  }[lang];

  static String timeout = {
    Locale.EN: "timeout",
    Locale.ID: "waktu berakhir"
  }[lang];

  static String checkVerification = {
    Locale.EN: "Check verification",
    Locale.ID: "Cek verifikasi"
  }[lang];

  static String dashboard = {
    Locale.EN: "Dashboard",
    Locale.ID: "Beranda"
  }[lang];

  static String helloTutor = {
    Locale.EN: "Hello, tutor",
    Locale.ID: "Halo, tutor"
  }[lang];

  static String profile = {
    Locale.EN: "Profile",
    Locale.ID: "Profil"
  }[lang];

  static String setting = {
    Locale.EN: "Setting",
    Locale.ID: "Pengaturan"
  }[lang];

  static String exit = {
    Locale.EN: "Exit",
    Locale.ID: "Keluar"
  }[lang];

  static String about = {
    Locale.EN: "About",
    Locale.ID: "Tentang"
  }[lang];

  static String help = {
    Locale.EN: "Help",
    Locale.ID: "Bantuan"
  }[lang];

  static String logout = {
    Locale.EN: "Logout",
    Locale.ID: "Logout"
  }[lang];
}//EOF