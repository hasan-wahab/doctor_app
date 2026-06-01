package com.neonweb.dralitherapy_patientapp;

import android.nfc.cardemulation.HostApduService;
import android.os.Bundle;
import android.util.Log;
import java.nio.charset.StandardCharsets;

public class MyHostApduService extends HostApduService {

    public static String virtualData = "USER12345";

    @Override
    public byte[] processCommandApdu(byte[] commandApdu, Bundle extras) {
        Log.d("HCE", "Received APDU: " + bytesToHex(commandApdu));

        // Convert virtualData to bytes
        byte[] dataBytes = virtualData.getBytes(StandardCharsets.UTF_8);

        // Append SW1 SW2 = 0x90 0x00 (success)
        byte[] response = new byte[dataBytes.length + 2];
        System.arraycopy(dataBytes, 0, response, 0, dataBytes.length);
        response[response.length - 2] = (byte) 0x90;
        response[response.leng