[![Newman API Tests](https://github.com/piotrpinderak/contract-driven-api-tests-dummyjson/actions/workflows/newman.yml/badge.svg?branch=main)](https://github.com/piotrpinderak/contract-driven-api-tests-dummyjson/actions/workflows/newman.yml)

# Contract-driven API Tests for DummyJSON (Products & Carts)

A Postman + Newman API test suite targeting the public DummyJSON API (no mocks).  
The suite validates data integrity, cross‑resource relations (cart → product), sorting rules, and negative scenarios.  
It runs both locally and in CI (GitHub Actions), producing an HTML report artifact.

## Tech Stack
- **Postman** — collection with tests  
- **Newman** — CLI runner  
- **GitHub Actions** — CI pipeline  
- **newman-reporter-htmlextra** — HTML report generator  

## Coverage

### Products
- List endpoint with pagination validation (`limit`, `skip`, response shape)
- Domain invariants (e.g., `price > 0`, non-empty `title`)
- Sorting validation (ascending price monotonicity)
- Negative scenario: non-existing product returns `404`

### Carts
- List endpoint with pagination validation
- Cart integrity rules:
  - `totalProducts == products.length`
  - `totalQuantity == sum(item.quantity)`
  - `item.total ≈ item.price * item.quantity`
  - `cart.total ≈ sum(item.total)`
  - `discountedTotal <= total`
- User‑scoped carts (`/carts/user/{userId}`) with ownership checks
- Relation validation: every product referenced in a cart exists (`/products/{id}`)
- Negative scenario: non-existing cart returns `404`

## Running Locally

Install Newman:
```bash
npm i -g newman
```

Run the collection:
```bash
newman run postman/collection.json --reporters cli
```

## HTML Report (CI)

After a GitHub Actions workflow run completes, download the generated HTML report:

1. Go to **Actions**
2. Open the latest run of `newman.yml`
3. In **Artifacts**, download `newman-html-report`
4. Open `newman-report.html` in your browser

## Project Structure

- `postman/collection.json` — Postman collection (requests + tests)  
- `.github/workflows/newman.yml` — CI workflow running Newman and exporting the HTML report  