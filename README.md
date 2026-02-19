# Alloy – Detecting a Session Token Design Flaw

This project presents an Alloy specification of a simplified hospital Patient Record System.  
By formally modeling the system architecture and analyzing it using Alloy Analyzer, we identify a design flaw in the session token management module that can lead to unintended access.

## Objective

To show how creating a formal specification and exploring system behaviors with Alloy can expose architectural security flaws early in system design.

**Modeled Privacy Policy:**

> A doctor can only access records of patients they are treating.

## Model Overview

- **Entities:** `Doctor`, `Patient`, `Record`, `SessionToken`  
- **State Variables:** `loggedInDoctor`, `activeToken`, `issuedTo`, `visibleRecord`  
- **Transitions:** `login`, `viewRecord`, `logout`, `stutter`  
- **Assertions:** Temporal properties to verify privacy guarantees  

## Key Insight

Formal modeling and analysis with Alloy reveals a design flaw in the session token management module that can result in unintended access.

## How to Run

1. Open the `.als` file in Alloy Analyzer (v6+).
2. Execute the assertions to observe generated counterexamples.
