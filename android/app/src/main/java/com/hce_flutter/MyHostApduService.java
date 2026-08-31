package com.hce_flutter;

import android.nfc.cardemulation.HostApduService;
import android.os.Bundle;
import android.util.Log;

import java.io.UnsupportedEncodingException;

public class MyHostApduService extends HostApduService {

    public static String virtualData = "USER12345";

    @Override
    public byte[] processCommandApdu(byte[] commandApdu, Bundle extras) {
        Log.d("HCE", "Received APDU: " + bytesToHex(commandApdu));

        // UTF-8: getBytes(String) works on all API levels Android supports (StandardCharsets overload is API 19+).
        byte[] dataBytes;
        try {
            dataBytes = virtualData.getBytes("UTF-8");
        } catch (UnsupportedEncodingException e) {
            // Single-arg AssertionError — compatible with all API levels for IDE checks.
            throw new AssertionError(e);
        }

        // Append SW1 SW2 = 0x90 0x00 (success)
        byte[] response = new byte[dataBytes.length + 2];
        System.arraycopy(dataBytes, 0, response, 0, dataBytes.length);
        response[response.length - 2] = (byte) 0x90;
        response[response.length - 1] = (byte) 0x00;

        // What the NFC reader will read (app payload, without status words)
        Log.d("HCE", "======= READER WILL READ =======");
        Log.d("HCE", "data (string): " + virtualData);
        Log.d("HCE", "data (hex)   : " + bytesToHex(dataBytes));
        Log.d("HCE", "full response: " + bytesToHex(response));
        Log.d("HCE", "================================");

        return response;
    }

    @Override
    public void onDeactivated(int reason) {
        Log.d("HCE", "HCE Deactivated: " + reason);
    }

    // Helper function
    private String bytesToHex(byte[] bytes) {
        if (bytes == null) return "";
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02X ", b));
        }
        return sb.toString();
    }
}