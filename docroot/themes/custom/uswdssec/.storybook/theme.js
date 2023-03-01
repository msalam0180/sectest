import { create } from '@storybook/theming';
import logo from '../source/images/sb-sec-logo.png';

const storybookTheme = create({
  appBg: '#F8F8F8',
  appContentBg: '#fff',
  barBg: '#273a56',
  barSelectedColor: '#6fa9ff',
  barTextColor: '#fff',
  base: 'light',
  brandTitle: 'SEC',
  brandUrl: '/',
  brandImage: logo,
  colorPrimary: '#273a56',
  colorSecondary: '#2F64B2',
  fontBase: '"Barlow", sans-serif',
  textColor: '#3f3f3f',
});

export default storybookTheme;

// Note: Cannot update text color in the sidebar and it is not accessible - github.com/storybookjs/storybook/issues/8935