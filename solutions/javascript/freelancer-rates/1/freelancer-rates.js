export function dayRate(ratePerHour) {
  return ratePerHour * 8;
}

export function daysInBudget(budget, ratePerHour) {
  return Math.floor(budget / dayRate(ratePerHour));
}

export function priceWithMonthlyDiscount(ratePerHour, numDays, discount) {
  const daysPerMonth = 22;
  const monthlyRate = dayRate(ratePerHour) * daysPerMonth;
  const fullMonths = Math.floor(numDays / daysPerMonth);
  const remainingDays = numDays % daysPerMonth;
  const discountedMonthCost = monthlyRate * (1 - discount);
  const total = Math.ceil(
    fullMonths * discountedMonthCost + remainingDays * dayRate(ratePerHour)
  );
  return total;
}
