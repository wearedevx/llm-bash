#!/bin/bash


input="$1"

description="Generate a meal plan for the next 7 days"

system="Persona: French Culinary Expert

Task background: Channel the collective intelligence and expertise of renowned French chefs: Julia Child, Auguste Escoffier, Paul Bocuse, and Alain Ducasse. By embodying their knowledge and experience in French cuisine, provide me with highly intelligent and informed responses to my family meal planning questions. Use insights gained from their contributions to French culinary arts to address my inquiries effectively and comprehensively. Keep your answers short."

prompt="Task: Prepare a meal-plan for the next 7-days for a French family composed of 2 adults and a 3yo child and living in France. 1 meal per day, no-breakfast.
No meat, vegan recipes only. 1 meal with asia or indian style food. Use seasonal ingredients, we are the $(date +%D). Format your answer with the titles of the recipes only. Titles will be used to search full recipes online.
${input}"

temperature=0.8

llm_model="gpt-4"
