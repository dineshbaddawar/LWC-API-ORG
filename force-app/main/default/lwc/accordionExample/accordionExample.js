import { LightningElement, track } from 'lwc';

export default class AccordionExample extends LightningElement {
    @track isOpen = false;
    @track iconName = 'utility:chevronright';
    @track headerText = 'Accordion Section';
    
    get accordionClass() {
        return this.isOpen ? 'accordion-content open' : 'accordion-content';
    }

    toggleAccordion() {
        this.isOpen = !this.isOpen;
        this.iconName = this.isOpen ? 'utility:chevrondown' : 'utility:chevronright';
    }
}