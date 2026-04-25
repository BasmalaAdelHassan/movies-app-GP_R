import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool isPasswordObscure = true;

  AuthBloc() : super(AuthInitialState()) {

    on<TogglePasswordVisibilityEvent>((event, emit) {
      isPasswordObscure = !isPasswordObscure;
      emit(PasswordVisibilityState(isPasswordObscure));
    });

    on<GoogleLoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await _googleSignIn.signOut();
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        if (googleUser != null) {
          final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          UserCredential userCredential = await _auth.signInWithCredential(credential);

          final userDoc = await _firestore.collection('Users').doc(userCredential.user!.uid).get();
          if (!userDoc.exists) {
            await _firestore.collection('Users').doc(userCredential.user!.uid).set({
              'uId': userCredential.user!.uid,
              'name': googleUser.displayName ?? "No Name",
              'email': googleUser.email,
              'phone': '',
              'avatar': googleUser.photoUrl ?? '',
              'favorites': [],
            });
          }

          emit(AuthSuccessState());
        } else {
          emit(AuthInitialState());
        }
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<LoginSubmittedEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(AuthSuccessState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<RegisterSubmittedEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        await _firestore.collection('Users').doc(userCredential.user!.uid).set({
          'uId': userCredential.user!.uid,
          'name': event.name,
          'email': event.email,
          'phone': event.phone,
          'avatar': event.avatar,
          'favorites': [],
        });

        emit(AuthSuccessState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });

    on<ForgotPasswordEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await _auth.sendPasswordResetEmail(email: event.email);
        emit(AuthSuccessState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });
  }
}