/**
 * Creates an random UUID, where the last part is time.
 * 'Randomly-Gene-rate-d...-TimeTimeTime' 
 * @returns an uuid formated as an string with - and no { }
 * License MIT 
 * Author Florian Grimm
 */
export function uuidWithTime(){
    const rest = crypto.randomUUID();
    const dt = new Date();
    const ticks = (
        dt.valueOf() 
        + 0x800000000000);
    const sdt = ticks.toString(16);
    const a = rest.substring(0,24);
    const b = sdt.substring(0, 12);
    const result = a+b;
    return result;
}
