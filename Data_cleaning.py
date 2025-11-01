import pandas as pd 

# Load the dataset

df = pd.read_csv('food_orders.csv')

# Convert date columns to datetime

df['Order Date and Time'] = pd.to_datetime(df['Order Date and Time'] , errors='coerce')
df['Delivery Date and Time'] = pd.to_datetime(df['Delivery Date and Time'] , errors='coerce')

# Create Delivery Duration (in minutes)

df['Delivery_Duration_min'] = (df['Delivery Date and Time'] - df['Order Date and Time']).dt.total_seconds() / 60

# Clean "Discounts and Offers" column

def clean_discount(value):
    value = str(value).strip().lower()
    
    if "none" in value or value == "" or value == "nan":
        return 0
    elif "%" in value:
        # Extract number before %
        try:
            return float(value.split('%')[0])
        except:
            return 0
    elif "off" in value:
        # Extract number before 'off'
        for word in value.split():
            if word.replace('.', '').isdigit():
                return float(word)
        return 0
    else:
        return 0
    
df['Discount_Percent_or_Amount'] = df['Discounts and Offers'].apply(clean_discount)

# Fill missing values with 0

numeric_cols = ['Order Value', 'Delivery Fee', 'Commission Fee', 
                'Payment Processing Fee', 'Refunds/Chargebacks']
for col in numeric_cols:
    df[col] = pd.to_numeric(df[col], errors='coerce').fillna(0)


# Calculate derived columns

df['Revenue'] = df['Order Value'] - df['Discount_Percent_or_Amount'] - df['Refunds/Chargebacks']
df['Total_Cost'] = df['Delivery Fee'] + df['Commission Fee'] + df['Payment Processing Fee']
df['Profit'] = df['Revenue'] - df['Total_Cost']


# Save cleaned dataset

df.to_csv("food_orders_cleaned.csv", index=False)

print("✅ Cleaning completed and saved as 'food_orders_cleaned.csv'")

