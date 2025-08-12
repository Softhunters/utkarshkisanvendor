# Keep rules for Google Credentials API used by smart_auth
-keep class com.google.android.gms.auth.api.credentials.** { *; }
-dontwarn com.google.android.gms.auth.api.credentials.**

# Keep rules for Razorpay
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Keep annotation classes sometimes used by R8
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

# General keep rules to avoid removing methods used via reflection
-keepattributes *Annotation*, InnerClasses
-keep class * extends java.lang.annotation.Annotation { *; }
