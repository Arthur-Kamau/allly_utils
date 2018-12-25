package com.araizen.kamau.allyutils;

import android.content.Context;
import android.content.CursorLoader;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.net.Uri;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;

import android.database.Cursor;
import android.provider.ContactsContract;
import android.provider.MediaStore;
import android.util.Log;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "com.araizen/modules/utils";

  @Override
  protected void onCreate(Bundle savedInstanceState) {

    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(new MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("getBatteryLevel")) {
          int batteryLevel = getBatteryLevel();

          if (batteryLevel != -1) {
            result.success(batteryLevel);
          } else {
            result.error("UNAVAILABLE", "Battery level not available.", null);
          }
        } else if (call.method.equals("getContacts")) {
          HashMap<String, String> contacts = getContacts();
          result.success(contacts);

        } else if (call.method.equals("getImagePaths")) {
          List<String> imagePaths = getImagePaths();
          result.success(imagePaths);
        } else if (call.method.equals("getAllVideoPaths")) {
          List<String> videoPaths = getAllVideoPaths();
          result.success(videoPaths);
        } else if (call.method.equals("getAllAudiosPaths")) {
          List<String> audioPaths = getAllAudiosPaths();
          result.success(audioPaths);
        } else if (call.method.equals("getAppsApk")) {
          List<String> apkPaths = getAppsApk();
          result.success(apkPaths);
        } else {
          result.notImplemented();
        }
      }
    });

  }

  private int getBatteryLevel() {
    int batteryLevel = -1;
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
    } else {
      Intent intent = new ContextWrapper(getApplicationContext()).registerReceiver(null,
          new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
      batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100)
          / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
    }

    return batteryLevel;
  }

  private HashMap<String, String> getContacts() {
    StringBuilder sb = new StringBuilder();
    HashMap<String, String> contacts = new HashMap<>();

    Cursor phones = null;
    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.ECLAIR) {
      phones = getContentResolver().query(ContactsContract.CommonDataKinds.Phone.CONTENT_URI, null, null, null, null);
    }
    while (phones.moveToNext()) {
      String name = phones.getString(phones.getColumnIndex(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME));
      String phoneNumber = phones.getString(phones.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER));
      
      contacts.put(name, phoneNumber);
    }
    phones.close();

    return contacts; // sb.toString();
  }

  private List<String> getImagePaths() {
    // The list of columns we're interested in:
    String[] columns = { MediaStore.Images.Media.DATA, MediaStore.Images.Media.DATE_ADDED };

    final Cursor cursor = getApplicationContext().getContentResolver().query(
        MediaStore.Images.Media.EXTERNAL_CONTENT_URI, // Specify
        // the
        // provider
        columns, // The columns we're interested in
        null, // A WHERE-filter query
        null, // The arguments for the filter-query
        MediaStore.Images.Media.DATE_ADDED + " DESC" // Order the results, newest first
    );

    List<String> result = new ArrayList<String>(cursor.getCount());

    if (cursor.moveToFirst()) {
      final int image_path_col = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
      do {
        result.add(cursor.getString(image_path_col));
      } while (cursor.moveToNext());
    }
    cursor.close();

    return result;
  }

  private List<String> getAppsApk() {

      List<String> meApk = new ArrayList<String>();
      PackageManager manager = getApplicationContext().getPackageManager();
      final List<PackageInfo> apps = manager.getInstalledPackages(0);
      for (PackageInfo packageInfo : apps) {
          ApplicationInfo applicationInfo = packageInfo.applicationInfo;
          boolean isSystemApp = ((applicationInfo.flags & ApplicationInfo.FLAG_SYSTEM) != 0);
          Log.i("SystemApps", packageInfo.packageName + ", isSystemApp="+isSystemApp);
          if(!isSystemApp){
              meApk.add(applicationInfo.name);
          }
      }


//    final Intent mainIntent = new Intent(Intent.ACTION_MAIN, null);
//    mainIntent.addCategory(Intent.CATEGORY_LAUNCHER);
//    List<ResolveInfo> apps = getPackageManager().queryIntentActivities(mainIntent, 0);
//    for (ResolveInfo info : apps) {
//      File file = new File(info.activityInfo.applicationInfo.publicSourceDir);
//      // Copy the .apk file to wherever
//      meApk.add(file.getAbsolutePath());
//    }

    return meApk;

  }

  private List<String> getAllVideoPaths() {
    Uri uri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI;
    String[] projection = { MediaStore.Video.VideoColumns.DATA };
    Cursor cursor = getContentResolver().query(uri, projection, null, null, null);
    ArrayList<String> pathArrList = new ArrayList<>();
    if (cursor != null) {
      while (cursor.moveToNext()) {
        pathArrList.add(cursor.getString(0));
      }
      cursor.close();
    }
    Log.e("all path", pathArrList.toString());
    return pathArrList;
  }

  private List<String> getAllAudiosPaths() {
    // List<File> files = new ArrayList<>();
    String[] projection = { MediaStore.Audio.AudioColumns.DATA, MediaStore.Audio.Media.DISPLAY_NAME };
    Cursor cursor = getApplicationContext().getContentResolver().query(MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
        projection, null, null, null);
    ArrayList<String> pathArrList = new ArrayList<>();
    try {
      cursor.moveToFirst();
      do {
        // files.add((new
        // File(cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.DATA)))));
        pathArrList.add(cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Audio.Media.DATA)));

      } while (cursor.moveToNext());

      cursor.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    return pathArrList;
  }

  // try this just in case
  public ArrayList<String> getAllMedia() {
    HashSet<String> videoItemHashSet = new HashSet<>();
    String[] projection = { MediaStore.Video.VideoColumns.DATA, MediaStore.Video.Media.DISPLAY_NAME };
    Cursor cursor = getApplicationContext().getContentResolver().query(MediaStore.Video.Media.EXTERNAL_CONTENT_URI,
        projection, null, null, null);
    try {
      cursor.moveToFirst();
      do {
        videoItemHashSet.add((cursor.getString(cursor.getColumnIndexOrThrow(MediaStore.Video.Media.DATA))));
      } while (cursor.moveToNext());

      cursor.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
    ArrayList<String> downloadedList = new ArrayList<>(videoItemHashSet);
    return downloadedList;
  }
}
