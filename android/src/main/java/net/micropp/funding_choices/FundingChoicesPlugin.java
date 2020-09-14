package net.micropp.funding_choices;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import android.os.Bundle;
import android.app.Activity;
import android.content.Context;

import com.google.android.ump.ConsentForm;
import com.google.android.ump.ConsentInformation;
import com.google.android.ump.ConsentRequestParameters;
import com.google.android.ump.FormError;
import com.google.android.ump.UserMessagingPlatform;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;


public class FundingChoicesPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  private Activity activity;
  private Context appContext;
  private MethodChannel channel;
  private ConsentInformation consentInformation;
  private ConsentForm consentForm;
  private boolean umpRequested;

  private void setUpUMP(@NonNull boolean tagForUnderAgeOfConsent) {
    this.umpRequested = true;
    if(this.activity == null) return;
    this.umpRequested = false;
    ConsentRequestParameters params = new ConsentRequestParameters.Builder().setTagForUnderAgeOfConsent(tagForUnderAgeOfConsent).build();
    consentInformation = UserMessagingPlatform.getConsentInformation(appContext);
    consentInformation.requestConsentInfoUpdate(
      activity,
      params,
      new ConsentInformation.OnConsentInfoUpdateSuccessListener() {
        @Override
        public void onConsentInfoUpdateSuccess() {
            if (consentInformation.isConsentFormAvailable()) {
              loadForm();
          }
        }
      },
      new ConsentInformation.OnConsentInfoUpdateFailureListener() {
        @Override
        public void onConsentInfoUpdateFailure(FormError formError) {
            // Handle the error.
        }
      }
    );
  }

  private void loadForm() {
    UserMessagingPlatform.loadConsentForm(
      activity,
      new UserMessagingPlatform.OnConsentFormLoadSuccessListener() {
        @Override
        public void onConsentFormLoadSuccess(ConsentForm cf) {
          consentForm = cf;
          if(consentInformation.getConsentStatus() == ConsentInformation.ConsentStatus.REQUIRED) {
            consentForm.show(
              activity,
              new ConsentForm.OnConsentFormDismissedListener() {
                @Override
                public void onConsentFormDismissed(@Nullable FormError formError) {
                  loadForm();
                }
              }
            );
          }
        }
      },
      new UserMessagingPlatform.OnConsentFormLoadFailureListener() {
        @Override
        public void onConsentFormLoadFailure(FormError formError) {
            /// Handle Error.
        }
      }
    );
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    this.channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "funding_choices");
    this.channel.setMethodCallHandler(this);
    this.appContext = flutterPluginBinding.getApplicationContext();
    this.umpRequested = false;
  }

  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
    if(this.umpRequested) {
      setUpUMP();
    }
  }

  @Override
  public void onDetachedFromActivity() {
    this.activity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
    if(this.umpRequested) {
      setUpUMP();
    }
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    this.activity = null;
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("init")) {
      this.umpRequested = false;
      final boolean tagForUnderAgeOfConsent = call.argument("tagForUnderAgeOfConsent");
      setUpUMP(tagForUnderAgeOfConsent);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

}
