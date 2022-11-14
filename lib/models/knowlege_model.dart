class Knowledge {
  final String title;
  final String imageUrl;
  final String shortDescription;
  final String symtomps;
  final String causes;
  final String treatment;
  final String prevention;

  Knowledge({
    required this.title,
    required this.imageUrl,
    required this.shortDescription,
    required this.symtomps,
    required this.causes,
    required this.treatment,
    required this.prevention,
  });
}

List<Knowledge> knowledgeList = [
  //1. Actinic
  Knowledge(
      title: 'Actinic Keratosis',
      imageUrl: "images/diseases/actinic_keratosis.jpg",
      shortDescription:
          'Actinic keratosis is a precancerous skin condition that develops on areas of the skin that have been exposed to the sun. It is caused by damage to the skin from ultraviolet (UV) rays. It is most common in people over 40 years of age. It is often found on the face, ears, scalp, neck, forearms, and hands. It is more common in people with fair skin. It is also more common in people who have had a lot of sun exposure over the years.',
      symtomps:
          '1. Rough, dry or scaly patch of skin, usually less than 1 inch (2.5 centimeters) in diameter.\n\n'
          '2. Flat to slightly raised patch or bump on the top layer of skin.\n\n'
          '3. In some cases, a hard, wartlike surface.\n\n'
          '4. Color variations, including pink, red or brown.\n\n'
          '5. Itching, burning, bleeding or crusting.\n\n'
          '6. New patches or bumps on sun-exposed areas of the head, neck, hands and forearms',
      causes:
          "The most common cause of actinic keratosis is too much exposure to ultraviolet (UV) light. UV light comes from the sun or indoor tanning equipment, such as tanning beds. UV light can damage your outer layer of skin cells, called keratinocytes.'",
      treatment:
          'Treatment options depend on how many actinic keratoses (AKs) you have and what they look like. Your healthcare provider may recommend removing the skin patches during an office visit.To remove actinic keratosis, your provider may use:\n\n'
          '1. Chemical peels: A chemical peel is like a medical-grade face mask. Your healthcare provider applies the peel during an office visit. The chemicals in the treatment safely destroy unwanted patches in your top layer of skin. In the first few days, the treated area will be sore and red. As the skin heals, you will see a new, healthy layer of skin.\n\n'
          '2. Cryotherapy: If you have one or two AKs, your provider may use cryotherapy. During this treatment, your provider uses a cold substance such as liquid nitrogen to freeze skin growths. Within a few days, these growths will blister and peel off.\n\n'
          '3. Excision: During this treatment, your healthcare provider first numbs the skin around your AK. Your provider then scrapes away or cuts out the AKs and stitches the area back together. Usually, your wound will heal in two to three weeks.\n\n'
          '4. Photodynamic therapy: If you have multiple AKs or AKs that return after treatment, your provider may recommend photodynamic therapy. This treatment uses creams and special light therapy to destroy precancerous skin cells. You will need to stay out of the sun for a few days while the treated skin heals.',
      prevention:
          '1. Applying sunscreen every day, even in cloudy weather or during winter, and re-applying often — at least every two hours. Use a broad-spectrum sunscreen with at least 30 sun protection factor (SPF) that blocks both UVA and UVB light.\n\n'
          '2. Avoiding sun exposure when UV light is most intense, between 10 a.m. and 2 p.m.\n\n'
          '3. Avoiding tanning salons, sun lamps and tanning beds.\n\n'
          '4. Wearing sun-safe clothing, such as long-sleeved shirts, long pants and hats.\n\n'),

  //2. Basal Cell Carcinoma
  Knowledge(
      title: 'Basal Cell Carcinoma',
      imageUrl: "images/diseases/basal_cell_carcinoma.jpg",
      shortDescription:
          'Basal cell carcinoma (BCC) is the most common type of skin cancer. It usually develops on areas of the skin that have been exposed to the sun. It is most common in people over 40 years of age. It is often found on the face, ears, scalp, neck, forearms, and hands. It is more common in people with fair skin. It is also more common in people who have had a lot of sun exposure over the years.',
      symtomps: '1. Lumps, bumps, pimples, scabs or scaly lesions on your skin'
          '2. The lump may be slightly see-through (translucent) and close to your normal skin color or white to pink, brown to black or black to blue'
          '3. The lump may appear shinier than the skin around it with tiny visible blood vessels'
          '4. The lump may grow slowly over time'
          '5. The lump may be itchy or painful'
          '6. The lump may form an ulcer, which can ooze clear fluid or bleed with contact.',
      causes:
          'Ultraviolet (UV) rays from the sun or from a tanning bed are the main cause of basal cell carcinoma. When UV rays hit your skin, over time, they can damage the DNA in your skin cells.'
          'In rarer cases, other factors can cause BCC. These include:'
          '1.	exposure to radiation'
          '2.	exposure to arsenic'
          '3.	complications from scars, infections, vaccinations, tattoos, and burns'
          '4.	chronic inflammatory skin conditions'
          'Once diagnosed with BCC, there is a strong likelihood of recurrence.',
      treatment:
          'Your provider will treat basal cell carcinoma by removing cancer from your body. To remove cancer, your treatment options could include:'
          '1.	Electrodessication and curettage: Scraping off the cancerous lump with a curette and then burning with a special electric needle.'
          '2.	Surgery: Removing the cancerous lump or lesion with a scalpel (excision or Mohs surgery).'
          '3.	Cryotherapy or cryosurgery: Freezing the cancerous lump to remove it.'
          '4.	Chemotherapy: Using powerful medicines to kill cancerous cells in your body.'
          '5.	Photodynamic therapy (PDT): Applying blue light and a light-sensitive agent to your skin.'
          '6.	Laser therapy: Using lasers (high-energy beams) to remove cancer instead of using a scalpel.'
          'Your provider will choose the best treatment option for you and your diagnosis by factoring in your overall health, your age, the location of the cancer and the size of the BCC.',
      prevention: ' 1.	Avoiding sun exposure from 10 a.m. to 4 p.m.'
          '2.	Avoiding tanning beds.'
          '3.	Using sunscreen with an SPF of 30 or higher each day and reapply sunscreen every two hours throughout the day if you’re outdoors or participating in activities like swimming.'
          '4.	Wearing clothing that has built-in sun protection (UPF), broad-brimmed hats and sunglasses.'
          '5.	Performing a skin self-exam once per month to check for any unusual lumps or lesions.'
          '6.	Visiting a dermatologist annually for a skin examination.'
          '7.	Contacting your healthcare provider if you have any questions about your skin or changes to your skin.'
          '8.	Taking nicotinamide (vitamin B3) 500 milligrams twice a day can reduce the risk of developing new BCC and SCC.'),

  //3.  dermatofibroma
  Knowledge(
    title: 'Dermatofibroma',
    imageUrl: "images/diseases/dermatofibroma.jpg",
    shortDescription:
        'Dermatofibroma is a benign skin growth that is usually found on the legs, arms, or trunk. It is a small, firm, painless, and noncancerous growth. It is most common in people over 40 years of age. It is more common',
    symtomps:
        'Apart from the bumps on the skin, dermatofibromas rarely cause additional symptoms. The growths can range in color from pink to reddish to brown.'
        'They are usually between 7 and 10 millimeters in diameter, although they can be smaller or larger than this range.'
        'Dermatofibromas are also usually firm to the touch. They can also be mildly sensitive to the touch, although most don’t cause symptoms.'
        'The growths can occur anywhere on the body but appear more often on exposed areas, such as the legs and arms.',
    causes:
        'Dermatofibromas are caused by an overgrowth of a mixture of different cell types in the dermis layer of the skin. The reasons why this overgrowth occurs aren’t known.'
        'The growths often develop after some type of small trauma to the skin, including a puncture from a splinter or bug bite',
    treatment:
        'Dermatofibromas are usually harmless and don’t require treatment. However, if you have a dermatofibroma that is causing you discomfort, your doctor may recommend removing it.',
    prevention:
        'Researchers don’t currently know exactly why the dermatofibromas occur in some people. Because the cause is unknown, there is no sure way to prevent dermatofibromas from developing.',
  ),
  //4. melanoma
  Knowledge(
      title: "Melanoma",
      imageUrl: "images/diseases/melanoma.jpg",
      shortDescription:
          "Melanoma is the most invasive skin cancer with the highest risk of death. While it’s a serious skin cancer, it's highly curable if caught early. Prevention and early treatment are critical, especially if you have fair skin, blonde or red hair and blue eyes. Melanoma, which means 'black tumor', is the most dangerous type of skin cancer. It grows quickly and has the ability to spread to any organ.",
      symtomps:
          "Melanomas can develop anywhere on your body. They most often develop in areas that have had exposure to the sun, such as your back, legs, arms and face."
          "Melanomas can also occur in areas that don't receive much sun exposure, such as the soles of your feet, palms of your hands and fingernail beds. These hidden melanomas are more common in people with darker skin. The first melanoma signs and symptoms often are:"
          "1.	A change in an existing mole"
          "2.	The development of a new pigmented or unusual-looking growth on your skin"
          "Melanoma doesn't always begin as a mole. It can also occur on otherwise normal-appearing skin.",
      causes:
          "It's likely that a combination of factors, including environmental and genetic factors, causes melanoma. Still, doctors believe exposure to ultraviolet (UV) radiation from the sun and from tanning lamps and beds is the leading cause of melanoma.",
      treatment:
          "1.	Melanoma Surgery: In the early stages, surgery has a high probability of being able to cure your melanoma. Usually performed in an office, a dermatologist numbs the skin with a local anesthetic and removes the melanoma and margins (healthy surrounding skin)."
          "2.	Lymphadenectomy: In cases where melanoma has spread, removal of the lymph nodes near the primary diagnosis site may be required. This can prevent the spread to other areas of your body."
          "3.	Metastasectomy: Metastasectomy is used to remove small melanoma bits from organs."
          "4.	Targeted cancer therapy: In this treatment option, drugs are used to attack specific cancer cells. This “targeted” approach goes after cancer cells, leaving healthy cells untouched."
          "5.	Radiation Therapy: Radiation therapy includes treatments with high-energy rays to attack cancer cells and shrink tumors."
          "6.	Immunotherapy: immunotherapy stimulates your own immune system to help fight the cancer.",
      prevention:
          "1.	Avoid sun and seek shade, especially between 10 a.m. and 4 p.m."
          "2.	Don’t use tanning beds. Use a spray tan (cosmetic) instead."
          "3.	Whenever possible, wear hats with brims, sunglasses, long-sleeved shirts and pants."
          "4.	Use a broad-spectrum sunscreen with a skin protection factor (SPF) of 30 or higher and reapply often, usually every 1.5 hours or more often if you’re swimming or sweating."
          "5.	Use a lip balm with sunscreen."
          "6.	Don't forget to apply sunscreen to young children and infants older than 6 months."),
  //5. nevus
  Knowledge(
      title: "Nevus",
      imageUrl: "images/diseases/nevus.jpg",
      shortDescription:
          "Moles (nevi) are a common type of skin growth. They often appear as small, dark brown spots and are caused by clusters of pigment-forming cells (melanocytes). Most people have 10 to 40 moles that appear during childhood and adolescence and may change in appearance or fade over time."
          "Most moles are harmless. Rarely, they become cancerous. Being aware of changes in your moles and other pigmented patches is important to detecting skin cancer, especially malignant melanoma.",
      symtomps:
          "The typical mole is a small brown spot. But moles come in different colors, shapes and sizes:"
          "1.	Color and texture: Moles can be brown, tan, black, blue, red or pink. They can be smooth, wrinkled, flat or raised. They may have hair growing from them."
          "2.	Shape:  Most moles are oval or round."
          "3.	Size: Moles are usually less than 1/4 inch (about 6 millimeters) in diameter — the size of a pencil eraser. Those present at birth (congenital nevi) can be bigger than usual, covering part of the face, torso or a limb."
          "Moles can develop anywhere on your body, including your scalp, armpits, under your nails, and between your fingers and toes. Most people have 10 to 40 moles. Many of these develop by age 50. Moles may change or fade away over time. With hormonal changes in adolescence and pregnancy, they may become darker and larger.",
      causes:
          "Moles are caused when cells in the skin called melanocytes grow in clusters. Melanocytes are generally distributed throughout the skin. They produce melanin, the natural pigment that gives skin its color.",
      treatment:
          "Most moles are harmless and don’t require treatment. However, if you have a mole that’s cancerous or could become cancerous, you’ll likely need to have it removed. You can also choose to have a benign nevus removed if you don’t like the way it looks."
          "Most nevi are removed with either a shave or excisional biopsy. Your doctor will likely recommend doing an excisional biopsy for cancerous nevi to make sure that they remove everything.",
      prevention:
          "Wearing clothes may be an effective way to prevent proliferation of nevi. Since a high nevus count is a strong predictor of melanoma, sunscreen use may be involved in melanoma occurrence because it may encourage recreational sun exposure."),
  //6. pigmented benign keratosis
  Knowledge(
      title: "Pigmented benign keratosis",
      imageUrl: "images/diseases/pigmented_benign_keratosis.jpg",
      shortDescription:
          "Pigmented benign keratosis is a common skin condition that causes small, rough, scaly patches of skin. It's also known as senile keratosis, solar keratosis, actinic keratosis, seborrheic keratosis, or senile lentigo. It's not contagious and doesn't cause any serious health problems. It's most common in older adults, but it can affect people of any age.",
      symtomps:
          "1.	A round or oval-shaped waxy or rough bump, typically on the face, chest, a shoulder or the back"
          "2.	A flat growth or a slightly raised bump with a scaly surface, with a characteristic 'pasted on' look"
          "3.	Varied size, from very small to more than 1 inch (2.5 centimeters) across"
          "4.	Varied number, ranging from a single growth to multiple growths"
          "5.	Very small growths clustered around the eyes or elsewhere on the face, sometimes called flesh moles or dermatosis papulosa nigra, common on Black or brown skin"
          "6.	Varied in color, ranging from light tan to brown or black"
          "7.	Itchiness",
      causes:
          "Experts don't completely understand what causes a seborrheic keratosis. This type of skin growth does tend to run in families, so there is likely an inherited tendency. If you've had one seborrheic keratosis, you're at risk of developing others."
          "A seborrheic keratosis isn't contagious or cancerous. ",
      treatment:
          "1.	Freezing the growth. Freezing a growth with liquid nitrogen (cryotherapy) can be an effective way to remove a seborrheic keratosis. It doesn't always work on raised, thicker growths. This method carries the risk of permanent loss of pigment, especially on Black or brown skin."
          "2.	Scraping (curettage) or shaving the skin's surface. First your doctor will numb the area and then use a scalpel blade to remove the growth. Sometimes shaving or scraping is used along with cryosurgery to treat thinner or flat growths."
          "3.	Burning with an electric current (electrocautery). First your doctor will numb the area and then destroy the growth with electrocautery. This method can be used alone or with scraping, especially when removing thicker growths. ",
      prevention:
          "There is no way to completely prevent the development of seborrheic keratoses. However, if you know you're at risk or you frequently develop these growths, working with a dermatologist means you can limit the impact this skin condition has on your life."),
  //7. seborrheic keratosis
  Knowledge(
    title: "Seborrheic keratosis",
    imageUrl: "images/diseases/seborrheic_keratosis.jpg",
    shortDescription:
        "Squamous cell cancer (SCC), also known as squamous cell carcinoma, is a type of cancer. It develops in squamous cells, which are the thin, flat cells that make up the outermost layer of your skin. Squamous cells are also found in other parts of your body such as your lungs, mucous membranes, digestive tract, and urinary tract."
        "SCC that forms in your skin is known as cutaneous SCC (cSCC). cSCC develops due to changes in the DNA of squamous cells, which causes them to multiply uncontrollably. It often forms on parts of your skin frequently exposed to sunlight like your face, neck, or arms.",
    symtomps: "1.	A firm, red nodule"
        "2.	A flat sore with a scaly crust"
        "3.	A new sore or raised area on an old scar or ulcer"
        "4.	A rough, scaly patch on your lip that may evolve to an open sore"
        "5.	A red sore or rough patch inside your mouth"
        "6.	A red, raised patch or wartlike sore on or in the anus or on your genitals",
    causes:
        "Squamous cell carcinoma of the skin occurs when the flat, thin squamous cells in the middle and outer layers of your skin develop changes (mutations) in their DNA. A cell's DNA contains the instructions that tell a cell what to do. The mutations tell the squamous cells to grow out of control and to continue living when normal cells would die."
        "Most of the DNA mutations in skin cells are caused by ultraviolet (UV) radiation found in sunlight and in commercial tanning lamps and tanning beds.",
    treatment:
        "1.	Simple excision. In this procedure, your doctor cuts out the cancerous tissue and a surrounding margin of healthy skin. Your doctor may recommend removing additional normal skin around the tumor in some cases (wide excision). To minimize scarring, especially on your face, consult a doctor skilled in skin reconstruction."
        "2.	Mohs surgery. During Mohs surgery, your doctor removes the cancer layer by layer, examining each layer under the microscope until no abnormal cells remain. This allows the surgeon to be certain the entire growth is removed and avoid taking an excessive amount of surrounding healthy skin."
        "3.	Radiation therapy. Radiation therapy uses high-energy beams, such as X-rays and protons, to kill cancer cells. Radiation therapy is sometimes used after surgery when there is an increased risk that the cancer will return. It might also be an option for people who can't undergo surgery.",
    prevention: "1.	Checking your skin once a month."
        "2.	Seeing a dermatologist annually."
        "3.	Using sunscreen. To be effective, sunscreens should be broad spectrum, at least SPF 30 and waterproof. It also needs to be applied to all exposed areas of the skin and repeated approximately every two hours or after swimming."
        "4.	Avoid tanning beds."
        "5.	Wearing protective clothing",
  ),
  // 8. vascular lesion
  Knowledge(
    title: "Vascular Lesion",
    imageUrl: "images/diseases/vascular_lesion.jpg",
    shortDescription:
        "Vascular lesions are relatively common abnormalities of the skin and underlying tissues, more commonly known as birthmarks. There are three major categories of vascular lesions: Hemangiomas, Vascular Malformations, and Pyogenic Granulomas. While these birthmarks can look similar at times, they each vary in terms of origin and necessary treatment.",
    symtomps:
        "They may present with a skin deformity, pulsatile mass, bleeding, ulceration, or secondary symptoms including arterial steal, venous congestion, and high output cardiac failure. These lesions demonstrate high flow on ultrasound; it can be difficult to identify the arterial origin or venous drainage of these lesions.",
    causes:
        "Although the cause is unknown, they are thought to occur because of abnormal persistence of vascular connections between arteries and veins that exist during embryologic development. Most of the DNA mutations in skin cells are caused by ultraviolet (UV) radiation found in sunlight and in commercial tanning lamps and tanning beds.",
    treatment:
        "Laser treatment is usually the best option for vascular lesions of the face. On the legs, injection of a medication to destroy the blood vessel (sclerotherapy) can be a better option for spider veins. Deeper veins may need treatment with surgery or very small lasers that are inserted into larger blood vessels.",
    prevention: "There is no any proven way to prevent vascular lesion.",
  )
];
