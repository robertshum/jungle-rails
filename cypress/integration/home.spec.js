/// <reference types="cypress" />

describe('Jungle Web App', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/');
  });

  it("There are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
});
