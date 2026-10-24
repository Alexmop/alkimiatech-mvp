# AlkimiaTech: Predictive Neurological Intelligence for Epilepsy Monitoring

**Technical Whitepaper (Research Prototype Phase)**

## 1. Abstract

AlkimiaTech is a HealthTech/MedTech research prototype focused on continuous seizure-risk forecasting through wearable physiological biomarkers. By integrating commercial smartwatches (e.g., Amazfit Bip 6) with a proprietary AI-driven software layer, AlkimiaTech aims to transform reactive epilepsy monitoring into proactive, predictive intelligence. This document outlines the technical architecture, current capabilities, and the proposed clinical validation roadmap.

## 2. Problem Statement

Epilepsy affects over 50 million people worldwide. Despite pharmacological advances, a significant percentage of patients experience unpredictable seizures, leading to severe anxiety, physical injuries, and an increased risk of Sudden Unexpected Death in Epilepsy (SUDEP). Current monitoring systems are predominantly reactive—they detect seizures after onset. There is a critical need for non-invasive, continuous, and predictive monitoring solutions.

## 3. Proposed Solution: The AlkimiaTech Architecture

AlkimiaTech does not aim to replace existing neurodiagnostic hardware. Instead, it functions as an **interoperable predictive intelligence layer**. The system is divided into three core layers:

### Layer 1: Physiological Data Acquisition & Prediction

- **Hardware:** Integration with commercial smartwatches via Bluetooth Low Energy (BLE).
- **Biomarkers:** Continuous monitoring of Heart Rate (HR), Heart Rate Variability (HRV), Oxygen Saturation (SpO₂), and movement (accelerometer).
- **Signal Processing:** Feature extraction from raw time-series data to identify pre-ictal physiological signatures.

### Layer 2: Detection and Emergency Response

- **Event Detection:** Real-time threshold analysis to identify anomalies.
- **Alert System:** Automated routing of alerts to caregivers, neurologists, and emergency services.
- **Location Services:** Integration of GPS data for autonomous patient localization during a crisis.

### Layer 3: Clinical Data Platform (Neuromap 3D)

- **Data Centralization:** A secure backend (FastAPI + SQLite) that stores longitudinal patient data.
- **Interoperability:** Designed to integrate with existing hospital databases and Electronic Health Records (EHR).
- **Visualization (Neuromap 3D):** A WebGL-based 3D brain visualization tool. It maps physiological activity and clinical EEG data onto anatomical brain regions, providing neurologists with an intuitive, 3D representation of the patient's neurological state.

## 4. Current Prototype Status (MVP)

- **Mobile Application:** Functional Flutter app with real-time BLE integration (tested with Amazfit Bip 6).
- **Backend API:** FastAPI server with data validation and simulated risk-scoring endpoints.
- **Neuromap 3D:** Interactive 3D brain model with anatomical mapping, live data binding, and clinical EEG PDF integration.
- **Security:** Validated against basic penetration testing (Nmap, API fuzzing) using Kali Linux.

## 5. Regulatory and Clinical Strategy

AlkimiaTech acknowledges the stringent requirements of the European Medical Device Regulation (MDR). The current prototype is classified as a **research tool**, not a diagnostic device.

- **Next Steps:** Collaboration with clinical partners for retrospective data validation and prospective pilot studies.
- **Long-term Goal:** CE MDR certification as a Class IIa Software as a Medical Device (SaMD) for seizure forecasting.

## 6. Conclusion and Call for Collaboration

AlkimiaTech is seeking partnerships with:

- **Neurotechnology companies** (e.g., Empatica, UNEEG) for API/SDK integration.
- **Clinical institutions** (e.g., Karolinska, CHUV) for data validation and pilot studies.
- **Wearable manufacturers** for hardware-software co-development.

_For technical documentation or partnership inquiries: hello@alkimiatech.dev_
